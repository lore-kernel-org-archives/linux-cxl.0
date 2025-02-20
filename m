Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C7A34CF5
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065871; cv=none; b=by9dHjKFHGqbr0HiY9rqC2ht/iZW6y0Vxd7nzuxSmefNGxezJ5Q8l5w2qWvm/3QLth0mgeThG+fBhyEbP05RzD0KBea/U7EIiVXvT87+dqjgnFQDAXwyKH1y0D6pZV9UsPZqTR+Nooj6vshb81kotRiGsu4Jlwb2qo3SZVOeA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065871; c=relaxed/simple;
	bh=U6wkZKJuUgil9LBfncrQvYKYTtwtTVUkDWtmIp+5OBE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qBWDkiRN0FQGEW8NmwdgUZM4oj6FDNUZf929+qaTsJVUUqhGaYG9VY1+NICpa6HBJswPsd9doqNxJuJ/vdVsQwLlDxaI0Uu+akOi0SLRzNvRUWqR8u/+w6tJKWOdxVEcOW13zCFfUBFbdMw+8mExWo0BttwYou5ywYoEXoXx5tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzHP865ndz6GBZC;
	Thu, 20 Feb 2025 23:34:20 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id CF908140119;
	Thu, 20 Feb 2025 23:37:46 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Feb 2025 16:37:46 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 20 Feb 2025 16:37:46 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"saeed@kernel.org" <saeed@kernel.org>, Li Ming <ming.li@zohomail.com>
Subject: RE: [PATCH v6 06/14] cxl: Setup exclusive CXL features that are
 reserved for the kernel
Thread-Topic: [PATCH v6 06/14] cxl: Setup exclusive CXL features that are
 reserved for the kernel
Thread-Index: AQHbgliILzagj5mciUKUq+IajY4Z+7NQVPPQ
Date: Thu, 20 Feb 2025 15:37:46 +0000
Message-ID: <3fc274862c2548efb259dfb96e083612@huawei.com>
References: <20250218225721.2682235-1-dave.jiang@intel.com>
 <20250218225721.2682235-7-dave.jiang@intel.com>
In-Reply-To: <20250218225721.2682235-7-dave.jiang@intel.com>
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
>Subject: [PATCH v6 06/14] cxl: Setup exclusive CXL features that are reser=
ved for
>the kernel
>
>Certain features will be exclusively used by components such as in kernel =
RAS
>driver. Setup an exclusion list that can be used to detect if a feature is=
 exclusive
>to the kernel.
>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>Reviewed-by: Li Ming <ming.li@zohomail.com>
>Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Tested-by: Shiju Jose <shiju.jose@huawei.com>

>---
> drivers/cxl/core/features.c | 28 ++++++++++++++++++++++++++++
> include/cxl/features.h      | 34 ++++++++++++++++++++++++++++++++++
> 2 files changed, 62 insertions(+)
>
>diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c ind=
ex
>17a82734a340..048ba4fc3538 100644
>--- a/drivers/cxl/core/features.c
>+++ b/drivers/cxl/core/features.c
>@@ -7,6 +7,28 @@
> #include "core.h"
> #include "cxlmem.h"
>
>+/* All the features below are exclusive to the kernel */ static const
>+uuid_t cxl_exclusive_feats[] =3D {
>+	CXL_FEAT_PATROL_SCRUB_UUID,
>+	CXL_FEAT_ECS_UUID,
>+	CXL_FEAT_SPPR_UUID,
>+	CXL_FEAT_HPPR_UUID,
>+	CXL_FEAT_CACHELINE_SPARING_UUID,
>+	CXL_FEAT_ROW_SPARING_UUID,
>+	CXL_FEAT_BANK_SPARING_UUID,
>+	CXL_FEAT_RANK_SPARING_UUID,
>+};
>+
>+static bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry) {
>+	for (int i =3D 0; i < ARRAY_SIZE(cxl_exclusive_feats); i++) {
>+		if (uuid_equal(&entry->uuid, &cxl_exclusive_feats[i]))
>+			return true;
>+	}
>+
>+	return false;
>+}
>+
> inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)  =
{
> 	return cxlds->cxlfs;
>@@ -47,6 +69,7 @@ get_supported_features(struct cxl_features_state *cxlfs)
> 	struct cxl_mbox_get_sup_feats_in mbox_in;
> 	struct cxl_feat_entry *entry;
> 	struct cxl_mbox_cmd mbox_cmd;
>+	int user_feats =3D 0;
> 	int count;
>
> 	count =3D cxl_get_supported_features_count(cxl_mbox);
>@@ -121,6 +144,10 @@ get_supported_features(struct cxl_features_state
>*cxlfs)
> 			return NULL;
>
> 		memcpy(entry, mbox_out->ents, retrieved);
>+		for (int i =3D 0; i < num_entries; i++) {
>+			if (!is_cxl_feature_exclusive(entry + i))
>+				user_feats++;
>+		}
> 		entry +=3D num_entries;
> 		/*
> 		 * If the number of output entries is less than expected, add the
>@@ -131,6 +158,7 @@ get_supported_features(struct cxl_features_state *cxlf=
s)
> 	} while (remain_feats);
>
> 	entries->num_features =3D count;
>+	entries->num_user_features =3D user_feats;
>
> 	return no_free_ptr(entries);
> }
>diff --git a/include/cxl/features.h b/include/cxl/features.h index
>ae56ef7ec9ab..d2cde46b0fec 100644
>--- a/include/cxl/features.h
>+++ b/include/cxl/features.h
>@@ -5,6 +5,39 @@
>
> #include <linux/uuid.h>
>
>+/* Feature UUIDs used by the kernel */
>+#define CXL_FEAT_PATROL_SCRUB_UUID
>		\
>+	UUID_INIT(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33, 0x75, 0x77, 0x4e,
>	\
>+		  0x06, 0xdb, 0x8a)
>+
>+#define CXL_FEAT_ECS_UUID
>	\
>+	UUID_INIT(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba, 0xb9, 0x69, 0x1e,
>	\
>+		  0x89, 0x33, 0x86)
>+
>+#define CXL_FEAT_SPPR_UUID
>	\
>+	UUID_INIT(0x892ba475, 0xfad8, 0x474e, 0x9d, 0x3e, 0x69, 0x2c, 0x91,
>	\
>+		  0x75, 0x68, 0xbb)
>+
>+#define CXL_FEAT_HPPR_UUID
>	\
>+	UUID_INIT(0x80ea4521, 0x786f, 0x4127, 0xaf, 0xb1, 0xec, 0x74, 0x59,
>	\
>+		  0xfb, 0x0e, 0x24)
>+
>+#define CXL_FEAT_CACHELINE_SPARING_UUID
>		\
>+	UUID_INIT(0x96C33386, 0x91dd, 0x44c7, 0x9e, 0xcb, 0xfd, 0xaf, 0x65,
>	\
>+		  0x03, 0xba, 0xc4)
>+
>+#define CXL_FEAT_ROW_SPARING_UUID
>		\
>+	UUID_INIT(0x450ebf67, 0xb135, 0x4f97, 0xa4, 0x98, 0xc2, 0xd5, 0x7f,
>	\
>+		  0x27, 0x9b, 0xed)
>+
>+#define CXL_FEAT_BANK_SPARING_UUID
>		\
>+	UUID_INIT(0x78b79636, 0x90ac, 0x4b64, 0xa4, 0xef, 0xfa, 0xac, 0x5d,
>	\
>+		  0x18, 0xa8, 0x63)
>+
>+#define CXL_FEAT_RANK_SPARING_UUID
>		\
>+	UUID_INIT(0x34dbaff5, 0x0552, 0x4281, 0x8f, 0x76, 0xda, 0x0b, 0x5e,
>	\
>+		  0x7a, 0x76, 0xa7)
>+
> /* Feature commands capability supported by a device */  enum
>cxl_features_capability {
> 	CXL_FEATURES_NONE =3D 0,
>@@ -134,6 +167,7 @@ struct cxl_features_state {
> 	struct cxl_dev_state *cxlds;
> 	struct cxl_feat_entries {
> 		int num_features;
>+		int num_user_features;
> 		struct cxl_feat_entry ent[] __counted_by(num_features);
> 	} *entries;
> };
>--
>2.48.1

