Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7141C2AB35
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430B9BA
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 07:05:11 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5rt26K6Vz6JB23;
	Thu, 12 Oct 2023 22:02:02 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 12 Oct 2023 15:05:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
	<mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 0/4] hw/cxl: Line length reduction and related
Date: Thu, 12 Oct 2023 15:05:10 +0100
Message-ID: <20231012140514.3697-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

No dependencies. Does not overlap with the other CXL series
[PATCH v5 0/3] hw/cxl: Add dummy ACPI QTG DSM
so either order is fine, or they can go via different paths.

v4: Use QEMU_BUILD_BUG_ON() rather than static_assert() with
    missing message. Thanks to Michael Tsirkin who caught this in
    a clang build failure.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>

Michael observed that the CXL code regularly went above the 80 character
recommendation and in many cases this was not necessary for readability.

This series is focused on tidying this up for the existing code so that
we can maintain the preferred formatting going forwards.

Jonathan Cameron (4):
  hw/cxl: Use a switch to explicitly check size in caps_reg_read()
  hw/cxl: Use switch statements for read and write of cachemem registers
  hw/cxl: CXLDVSECPortExtensions renamed to CXLDVSECPortExt
  hw/cxl: Line length reductions

 include/hw/cxl/cxl_component.h |   3 +-
 include/hw/cxl/cxl_device.h    |   5 +-
 include/hw/cxl/cxl_events.h    |   3 +-
 include/hw/cxl/cxl_pci.h       |   6 +-
 hw/cxl/cxl-cdat.c              |   3 +-
 hw/cxl/cxl-component-utils.c   | 128 ++++++++++++++++++++-------------
 hw/cxl/cxl-device-utils.c      |  11 +--
 hw/cxl/cxl-events.c            |   9 ++-
 hw/cxl/cxl-mailbox-utils.c     |  21 ++++--
 hw/mem/cxl_type3.c             |  31 ++++----
 hw/mem/cxl_type3_stubs.c       |   5 +-
 hw/pci-bridge/cxl_downstream.c |   2 +-
 hw/pci-bridge/cxl_root_port.c  |   2 +-
 hw/pci-bridge/cxl_upstream.c   |   2 +-
 14 files changed, 143 insertions(+), 88 deletions(-)

-- 
2.39.2

