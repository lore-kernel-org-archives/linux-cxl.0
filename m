Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BC7802
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26371CA
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 05:56:20 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5qLc3DCvz6J9vH;
	Thu, 12 Oct 2023 20:53:12 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 12 Oct 2023 13:56:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
	<mst@redhat.com>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	<thuth@redhat.com>
Subject: [PATCH v5 0/3] hw/cxl: Add dummy ACPI QTG DSM
Date: Thu, 12 Oct 2023 13:56:20 +0100
Message-ID: <20231012125623.21101-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series wraps Dave Jiang's v4 with tests as per v2.
The kernel code using this is now at v10 and reflects the changes made here.

https://lore.kernel.org/linux-cxl/33155160-b627-4d70-b7f7-0fba162183c7@intel.com/T/#t

The discussions around the QEMU patches resulted in significant fixes
to the kernel code - which is great. Thanks to all involved.

Changes since v4:
- Add updated bios table to reflect the changs made in v3/v4

Based-on: qemu/master a51e5124a6

Key thing to note vs V2 is that this now returns a package of integers
and the example returns a package with two elements in it.
This corresponds to a firmware saying that for any input parameters
the QTGs should be used in order of preference 0 then 1.

As per patch 2 description:

Add a simple _DSM call support for the ACPI0017 device to return fake QTG
ID values of 0 and 1 in all cases. This for _DSM plumbing testing from the OS.

Following edited for readability

Device (CXLM)
{
    Name (_HID, "ACPI0017")  // _HID: Hardware ID
...
    Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
    {
        If ((Arg0 == ToUUID ("f365f9a6-a7de-4071-a66a-b40c0b4f8e52")))
        {
            If ((Arg2 == Zero))
            {
                Return (Buffer (One) { 0x01 })
            }

            If ((Arg2 == One))
            {
                Return (Package (0x02)
                {
                    One,
                    Package (0x02)
                    {
                        Zero,
                        One
                    }
                })
            }
        }
    }


Dave Jiang (1):
  hw/cxl: Add QTG _DSM support for ACPI0017 device

Jonathan Cameron (2):
  tests/acpi: Allow update of DSDT.cxl
  tests/acpi: Update DSDT.cxl with QTG DSM

 include/hw/acpi/cxl.h        |   1 +
 hw/acpi/cxl.c                |  69 +++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c         |   1 +
 tests/data/acpi/q35/DSDT.cxl | Bin 9655 -> 9713 bytes
 4 files changed, 71 insertions(+)

-- 
2.39.2

