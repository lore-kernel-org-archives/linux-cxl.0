Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602D01F8BC5
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065843; cv=none; b=DDaLe6TeBh4uloX7+NWIdE4wrxtGH5XYH/oD5cjS8GjRFlHWjbVA0WKDn3mAYFNWe4YkE6wyyVsa0VihpRuoJPwm6Pci1bs+3jxgwT4cE7z9IA7WXlI3Lp7u/NTF9xmK8MuKJrSAWtABWcnnxpg2Kuhqnd25+lPAvn3WgpqZ2Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065843; c=relaxed/simple;
	bh=AqrY6x2Oa7H0C0E9CG9OWYbyklPGzerEDLOZLeNhkV8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Un1/t6L8fra7rPUAH/FuMcgqlDxpwj/TACHomxaK99oXvUFrugAZpcTC/eqXrLEipS+IsjJ9nWqo41JOeuZqvD3KRtrxmF1uJ1imOBnRR0Ijx6ggzmTbOxLLcON2PHNmguFr4ErqEtT/9MnfZoggHQxWiEmvdmQcyhCVsJ+R21A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzHPX0dR2z6GC18;
	Thu, 20 Feb 2025 23:34:40 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
	by mail.maildlp.com (Postfix) with ESMTPS id D115C1400DD;
	Thu, 20 Feb 2025 23:37:17 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Feb 2025 16:37:17 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 20 Feb 2025 16:37:17 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"saeed@kernel.org" <saeed@kernel.org>, Li Ming <ming.li@zohomail.com>
Subject: RE: [PATCH v6 01/14] cxl: Enumerate feature commands
Thread-Topic: [PATCH v6 01/14] cxl: Enumerate feature commands
Thread-Index: AQHbgliPCOx0twyWAESFtDPN6onNEbNQVB2A
Date: Thu, 20 Feb 2025 15:37:17 +0000
Message-ID: <a6e14cb3fb4444b394e62baf1ed8dd23@huawei.com>
References: <20250218225721.2682235-1-dave.jiang@intel.com>
 <20250218225721.2682235-2-dave.jiang@intel.com>
In-Reply-To: <20250218225721.2682235-2-dave.jiang@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>-----Original Message-----
>From: Dave Jiang <dave.jiang@intel.com>
>Sent: 18 February 2025 22:55
>To: linux-cxl@vger.kernel.org
>Cc: dan.j.williams@intel.com; ira.weiny@intel.com; vishal.l.verma@intel.co=
m;
>alison.schofield@intel.com; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave@stgolabs.net; jgg@nvidia.com; Shiju
>Jose <shiju.jose@huawei.com>; saeed@kernel.org; Li Ming
><ming.li@zohomail.com>
>Subject: [PATCH v6 01/14] cxl: Enumerate feature commands
>
>Add feature commands enumeration code in order to detect and enumerate the
>3 feature related commands "get supported features", "get feature", and "s=
et
>feature". The enumeration will help determine whether the driver can issue=
 any
>of the 3 commands to the device.
>
>Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>Reviewed-by: Li Ming <ming.li@zohomail.com>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Tested-by: Shiju Jose <shiju.jose@huawei.com>

>---
> drivers/cxl/core/mbox.c | 36 +++++++++++++++++++++++++++++++++++-
> drivers/cxl/cxlmem.h    |  3 +++
> include/cxl/features.h  | 13 +++++++++++++
> include/cxl/mailbox.h   |  3 +++
> 4 files changed, 54 insertions(+), 1 deletion(-)  create mode 100644
>include/cxl/features.h
>
>diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c index
>9c1b9e353e3e..78c5346e3e89 100644
>--- a/drivers/cxl/core/mbox.c
>+++ b/drivers/cxl/core/mbox.c
>@@ -706,6 +706,35 @@ static int cxl_xfer_log(struct cxl_memdev_state *mds,
>uuid_t *uuid,
> 	return 0;
> }
>
>+static int check_features_opcodes(u16 opcode, int *ro_cmds, int
>+*wr_cmds) {
>+	switch (opcode) {
>+	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
>+	case CXL_MBOX_OP_GET_FEATURE:
>+		(*ro_cmds)++;
>+		return 1;
>+	case CXL_MBOX_OP_SET_FEATURE:
>+		(*wr_cmds)++;
>+		return 1;
>+	default:
>+		return 0;
>+	}
>+}
>+
>+/* 'Get Supported Features' and 'Get Feature' */
>+#define MAX_FEATURES_READ_CMDS	2
>+static void set_features_cap(struct cxl_mailbox *cxl_mbox,
>+			     int ro_cmds, int wr_cmds)
>+{
>+	/* Setting up Features capability while walking the CEL */
>+	if (ro_cmds =3D=3D MAX_FEATURES_READ_CMDS) {
>+		if (wr_cmds)
>+			cxl_mbox->feat_cap =3D CXL_FEATURES_RW;
>+		else
>+			cxl_mbox->feat_cap =3D CXL_FEATURES_RO;
>+	}
>+}
>+
> /**
>  * cxl_walk_cel() - Walk through the Command Effects Log.
>  * @mds: The driver data for the operation @@ -721,7 +750,7 @@ static voi=
d
>cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
> 	struct cxl_cel_entry *cel_entry;
> 	const int cel_entries =3D size / sizeof(*cel_entry);
> 	struct device *dev =3D mds->cxlds.dev;
>-	int i;
>+	int i, ro_cmds =3D 0, wr_cmds =3D 0;
>
> 	cel_entry =3D (struct cxl_cel_entry *) cel;
>
>@@ -735,6 +764,9 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds,
>size_t size, u8 *cel)
> 			enabled++;
> 		}
>
>+		enabled +=3D check_features_opcodes(opcode, &ro_cmds,
>+						  &wr_cmds);
>+
> 		if (cxl_is_poison_command(opcode)) {
> 			cxl_set_poison_cmd_enabled(&mds->poison, opcode);
> 			enabled++;
>@@ -748,6 +780,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds,
>size_t size, u8 *cel)
> 		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
> 			enabled ? "enabled" : "unsupported by driver");
> 	}
>+
>+	set_features_cap(cxl_mbox, ro_cmds, wr_cmds);
> }
>
> static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct
>cxl_memdev_state *mds) diff --git a/drivers/cxl/cxlmem.h
>b/drivers/cxl/cxlmem.h index a0a49809cd76..55c55685cb39 100644
>--- a/drivers/cxl/cxlmem.h
>+++ b/drivers/cxl/cxlmem.h
>@@ -490,6 +490,9 @@ enum cxl_opcode {
> 	CXL_MBOX_OP_GET_LOG_CAPS	=3D 0x0402,
> 	CXL_MBOX_OP_CLEAR_LOG           =3D 0x0403,
> 	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST =3D 0x0405,
>+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	=3D 0x0500,
>+	CXL_MBOX_OP_GET_FEATURE		=3D 0x0501,
>+	CXL_MBOX_OP_SET_FEATURE		=3D 0x0502,
> 	CXL_MBOX_OP_IDENTIFY		=3D 0x4000,
> 	CXL_MBOX_OP_GET_PARTITION_INFO	=3D 0x4100,
> 	CXL_MBOX_OP_SET_PARTITION_INFO	=3D 0x4101,
>diff --git a/include/cxl/features.h b/include/cxl/features.h new file mode=
 100644
>index 000000000000..357d3acf8429
>--- /dev/null
>+++ b/include/cxl/features.h
>@@ -0,0 +1,13 @@
>+/* SPDX-License-Identifier: GPL-2.0-only */
>+/* Copyright(c) 2024-2025 Intel Corporation. */ #ifndef
>+__CXL_FEATURES_H__ #define __CXL_FEATURES_H__
>+
>+/* Feature commands capability supported by a device */ enum
>+cxl_features_capability {
>+	CXL_FEATURES_NONE =3D 0,
>+	CXL_FEATURES_RO,
>+	CXL_FEATURES_RW,
>+};
>+
>+#endif
>diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h index
>cc894f07a435..c4e99e2e3a9d 100644
>--- a/include/cxl/mailbox.h
>+++ b/include/cxl/mailbox.h
>@@ -3,6 +3,7 @@
> #ifndef __CXL_MBOX_H__
> #define __CXL_MBOX_H__
> #include <linux/rcuwait.h>
>+#include <cxl/features.h>
> #include <uapi/linux/cxl_mem.h>
>
> /**
>@@ -51,6 +52,7 @@ struct cxl_mbox_cmd {
>  * @mbox_mutex: mutex protects device mailbox and firmware
>  * @mbox_wait: rcuwait for mailbox
>  * @mbox_send: @dev specific transport for transmitting mailbox commands
>+ * @feat_cap: Features capability
>  */
> struct cxl_mailbox {
> 	struct device *host;
>@@ -60,6 +62,7 @@ struct cxl_mailbox {
> 	struct mutex mbox_mutex; /* lock to protect mailbox context */
> 	struct rcuwait mbox_wait;
> 	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd
>*cmd);
>+	enum cxl_features_capability feat_cap;
> };
>
> int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host);
>--
>2.48.1

