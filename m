Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5432DFF2C;
	Thu,  3 Jul 2025 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751536366; cv=none; b=M6LUIzyIKNZ8XF9ACDDuza3lRruJQGDS4xh2qanRsepwPGaUYsHatXD5o/dANgePBdIIKa4aD3AXqlvyFefZz3Jugy2B2PMT1TGiq8WEVM7rwCzFUVaOmYfA0D1XTn4lHX+J6RzfHGX2EaJQhsr/MdA3FboCj+V15/ppGWf934E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751536366; c=relaxed/simple;
	bh=relfWXnrPhkcPVxI2hsN+5MmYdAWWBCpDSurS9C7OhM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CSAx7xRX58kHKZeLVkYufbrWMwuPAeUotlqyuqvrsLH9BAd38go0UOnrSfqmnziyVTvC++Qnp7otPsDgjLdNdIx6gzMpbP8zCax6ptpTxrCNKYnna246yQkI4A5fDWpu1PNBrtmOLyyYbBvKBEuM+hFPiH8uL4PsYs2kMQNoNA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXsVz1FC3z6DJ7R;
	Thu,  3 Jul 2025 17:52:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D21611402F0;
	Thu,  3 Jul 2025 17:52:39 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Jul 2025 11:52:39 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 3 Jul 2025 11:52:39 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Li Ming <ming.li@zohomail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] cxl/edac: Fix wrong dpa checking for PPR operation
Thread-Topic: [PATCH v2 2/3] cxl/edac: Fix wrong dpa checking for PPR
 operation
Thread-Index: AQHb6yHtbMaErxclN06w38KqXsN4c7QgJJ4A
Date: Thu, 3 Jul 2025 09:52:39 +0000
Message-ID: <e30e60570f1b4dc99a1c2b42f4c613ac@huawei.com>
References: <20250702072008.468371-1-ming.li@zohomail.com>
 <20250702072008.468371-2-ming.li@zohomail.com>
In-Reply-To: <20250702072008.468371-2-ming.li@zohomail.com>
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
>From: Li Ming <ming.li@zohomail.com>
>Sent: 02 July 2025 08:20
>To: akpm@linux-foundation.org; andriy.shevchenko@linux.intel.com;
>bhelgaas@google.com; ilpo.jarvinen@linux.intel.com; dave@stgolabs.net;
>Jonathan Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>dan.j.williams@intel.com; Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org; Li Ming
><ming.li@zohomail.com>
>Subject: [PATCH v2 2/3] cxl/edac: Fix wrong dpa checking for PPR operation
>
>DPA 0 is considered invalid in cxl_do_ppr(), but per Table 8-143. "Get Par=
tition
>Info Output Payload" in CXL r3.2 section 8.2.10.9.2.1 "Get Partition Info(=
Opcode
>4100h)", it mentions that DPA 0 is a valid address of a CXL device. So the=
 correct
>implementation should be checking if the DPA is in the DPA range of the CX=
L
>device rather than checking if the DPA is equal to 0.
>
>Fixes: be9b359e056a ("cxl/edac: Add CXL memory device soft PPR control
>feature")
>Signed-off-by: Li Ming <ming.li@zohomail.com>
Hi Ming,
Thanks for the fix.=20

Just found that, along with Table 8-143,  CXL spec 3.2 Device Decode Logic =
(Page 576) describes as
"The DPA mappings for a device typically start at 'DPA 0' for Decoder[0] an=
d=20
are sequentially accumulated with each additional decoder used"

Tested-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
>---
> drivers/cxl/core/edac.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c index
>623aaa4439c4..1cf65b1538b9 100644
>--- a/drivers/cxl/core/edac.c
>+++ b/drivers/cxl/core/edac.c
>@@ -1923,8 +1923,11 @@ static int cxl_ppr_set_nibble_mask(struct device
>*dev, void *drv_data,  static int cxl_do_ppr(struct device *dev, void *drv=
_data,
>u32 val)  {
> 	struct cxl_ppr_context *cxl_ppr_ctx =3D drv_data;
>+	struct cxl_memdev *cxlmd =3D cxl_ppr_ctx->cxlmd;
>+	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
>
>-	if (!cxl_ppr_ctx->dpa || val !=3D EDAC_DO_MEM_REPAIR)
>+	if (!resource_contains_addr(&cxlds->dpa_res, cxl_ppr_ctx->dpa) ||
>+	    val !=3D EDAC_DO_MEM_REPAIR)
> 		return -EINVAL;
>
> 	return cxl_mem_perform_ppr(cxl_ppr_ctx);
>--
>2.34.1


Thanks,
Shiju
