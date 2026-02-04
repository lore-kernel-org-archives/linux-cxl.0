Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECC8125D0
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226410; cv=none; b=JH43+7/kkSVwEHALXv/yh5PMlf4afiCVZPVHs6rXPZvq+Cv6aWsahdgLSH7v/I6fCQ0BnqS/qzqDaIl3ygvIu8T+DLmivcBS1QR1x6alMnKX3/Pk8beblj7S/BYfZGTZX28R8T9Z43CelHbSnSeu94UsXRutjvELSOkqsT3obts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226410; c=relaxed/simple;
	bh=GGvRgy4+qnfLHnsbyS74ks+I6t2LllPs/Fnbhf20Kh4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhV/pa3q2vurd87xnIAiKwzA44h8mqw/Ww3al2HLX/+wYWN5UC6IFRtERR0N9UaBu4AvLIAKXLTMm0J93TDuPI0GwvzLJ8QW8yWk0zHacdeYX8h6nQx9OBRwFlWGM/SGxZEqq1nJXuAza2llnpu2QsaPOubtYnA+q5mZDJip9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5nVZ1RWVzJ46BN;
	Thu,  5 Feb 2026 01:32:38 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 883624056A;
	Thu,  5 Feb 2026 01:33:27 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Feb 2026 17:33:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, Arpit Kumar
	<arpit1.kumar@samsung.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [PATCH qemu v5 2/3] hw/cxl: Get Physical Port State - update for PCIe flit mode
Date: Wed, 4 Feb 2026 17:32:22 +0000
Message-ID: <20260204173223.44122-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204173223.44122-1-Jonathan.Cameron@huawei.com>
References: <20260204173223.44122-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

Recent support for 256B flits, was not accounted for in this FMAPI command
that should be retrieving the current status of Physical Switch Ports.

Note x-flit-mode control is via the downstream devices, so for USPs the
property must be checked to establish support, but for DSPs this mode is
always supported (control is with the next port downstream, typically the
end point.  All cases the linksta2 register may be queried to obtain
current status.  Note the PCI spec is a little confusing as it refers to
this bit only being non 0 if Device Readiness Status (DRS) is in particular
states (basically link trained) but Flit mode is a separate feature and DRS
may not be present. It is not yet emulated in QEMU. So assume that we
should reflect what states DRS would be reporting if it were actually
present.

One small thing to note is that the current link width for a port with
nothing connected reports the same as the capability. This is odd but valid
because the value under these circumstances is undefined (PCIe r6.2 table
7-26 Link Status Register - field Current Link Speed.)

Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 1c8cbe0f682d..b6ac987ee021 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -627,9 +627,26 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
             port->config_state = CXL_PORT_CONFIG_STATE_DSP;
             if (ds_dev) {
                 if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
+                    uint16_t lnksta2;
+
+                    if (!port_dev->exp.exp_cap) {
+                        return CXL_MBOX_INTERNAL_ERROR;
+                    }
+
+                    lnksta2 = port_dev->config_read(port_dev,
+                                  port_dev->exp.exp_cap + PCI_EXP_LNKSTA2,
+                                  sizeof(lnksta2));
+
                     /* Assume MLD for now */
                     port->connected_device_type =
                         CXL_PORT_CONNECTED_DEV_TYPE_3_MLD;
+                    if (lnksta2 & PCI_EXP_LNKSTA2_FLIT) {
+                        port->connected_device_mode =
+                            CXL_PORT_CONNECTED_DEV_MODE_256B;
+                    } else {
+                        port->connected_device_mode =
+                            CXL_PORT_CONNECTED_DEV_MODE_68B_VH;
+                    }
                 } else {
                     port->connected_device_type =
                         CXL_PORT_CONNECTED_DEV_TYPE_PCIE;
@@ -642,12 +659,17 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
                 port->connected_device_mode =
                     CXL_PORT_CONNECTED_DEV_MODE_NOT_CXL_OR_DISCONN;
             }
+            /* DSP currently always support modes implemented in QEMU */
+            port->supported_cxl_mode_bitmask = CXL_PORT_SUPPORTS_68B_VH |
+                CXL_PORT_SUPPORTS_256B;
             port->supported_ld_count = 3;
         } else if (usp->port == in->ports[i]) { /* USP */
             port_dev = PCI_DEVICE(usp);
             port->config_state = CXL_PORT_CONFIG_STATE_USP;
             port->connected_device_type = 0; /* Reserved for USP */
             port->connected_device_mode = 0; /* Reserved for USP */
+            port->supported_cxl_mode_bitmask = CXL_PORT_SUPPORTS_68B_VH |
+                (CXL_USP(usp)->flitmode ? CXL_PORT_SUPPORTS_256B : 0);
         } else {
             return CXL_MBOX_INVALID_INPUT;
         }
@@ -676,8 +698,6 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
         /* TODO: Track down if we can get the rest of the info */
         port->ltssm_state = 0x7;
         port->first_lane_num = 0;
-        port->link_state = 0;
-        port->supported_cxl_mode_bitmask = CXL_PORT_SUPPORTS_68B_VH;
     }
 
     pl_size = sizeof(*out) + sizeof(*out->ports) * in->num_ports;
-- 
2.51.0

