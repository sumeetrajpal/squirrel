// MIT License

// Copyright (c) 2016-2017 Mystic Pants Pty Ltd

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

class AgentTestCase extends ImpTestCase {

    conctr = null;

    function setUp() {
        // Conctr credentials. Requires user input.
        const APP_ID = "Enter your conctr application id";
        const API_KEY = "Enter your conctr API key";
        const MODEL = "Enter your conctr model";

        conctr = Conctr(APP_ID, API_KEY, MODEL);
        return "Hi from #{__FILE__}!";
    }

    function testSendData() {
        return Promise(function(resolve, reject) {
            // Ensure this payload matches your model
            local payload = {
                "temperature": 15,
                "humidity": 80,
            }

            // Send the payload
            conctr.sendData(payload, function(err, resp) {
                if (err) reject(err);

                // assert the data was accepted
                this.assertEqual(resp.statuscode, 201);
                resolve();
            }.bindenv(this))

        }.bindenv(this))
    }

    function testSetDeviceId() {
        return Promise(function(resolve, reject) {

            local newDeviceId = "testDevice";

            // Ensure that the device ids do not already match
            this.assertTrue(conctr._device_id != newDeviceId);

            // Change the device id
            conctr.setDeviceId("testDevice");

            // Check new device id was set
            this.assertEqual(conctr._device_id, newDeviceId);
            resolve();
        }.bindenv(this))
    }

    function tearDown() {
        return "Test finished";
    }
}