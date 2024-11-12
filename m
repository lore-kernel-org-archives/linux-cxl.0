Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248020C499
	for <linux-cxl@vger.kernel.org>; Tue, 12 Nov 2024 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402718; cv=none; b=pcDJiciyPi5C0g7W15715t8NIn/O6+wHV3kMWFb4pArJB4skwlaCbPTejwvMflxMRfHwskDyojSJS4O8/5Y/8e6kzlc1nXB29kLGz2g9q5vjSBaqUm2T4jXXKSjhqWAcfPtSG5WciNUJmhq+3od2aeuztOROEMu5ROcO2Yn+29s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402718; c=relaxed/simple;
	bh=taf1W0mJysEfFBJ40ZqRkucl97oA/7kbQl3Om3X3RPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M/zbRu5T7Rh2j/+QIjuLxdbRon62ger+M9Xiu4EOEHPRr2RaWXCmsvpoPxGeq4k5oz+2cI3hPHxZnEqQ6F7aWCtu2ms0fdSxf44zgkHoIxoUCih/K+LwHdyXSmGE2K0rOgdf0N0XZOcohfAU3HyvZlD3dKBaC/H9HY5QOJne6e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xngdm6v4Lz6LD3Y;
	Tue, 12 Nov 2024 17:11:40 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 259B71400CA;
	Tue, 12 Nov 2024 17:11:52 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 10:11:51 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 12 Nov 2024 10:11:51 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, Fan Ni <fan.ni@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, Peter Maydell <peter.maydell@linaro.org>,
	"shiju.jose@huwei.com" <shiju.jose@huwei.com>
CC: Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH qemu] hw/cxl: Check for zero length features in
 cmd_features_set_feature()
Thread-Topic: [PATCH qemu] hw/cxl: Check for zero length features in
 cmd_features_set_feature()
Thread-Index: AQHbMgf16almpwDf4kOiOkWfyi9OkLKzYVpA
Date: Tue, 12 Nov 2024 09:11:51 +0000
Message-ID: <281da98659e94080be4028b8111e35f4@huawei.com>
References: <20241108175814.1248278-1-Jonathan.Cameron@huawei.com>
In-Reply-To: <20241108175814.1248278-1-Jonathan.Cameron@huawei.com>
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
>From: qemu-devel-bounces+shiju.jose=3Dhuawei.com@nongnu.org <qemu-devel-
>bounces+shiju.jose=3Dhuawei.com@nongnu.org> On Behalf Of Jonathan Cameron
>via
>Sent: 08 November 2024 17:58
>To: Michael S . Tsirkin <mst@redhat.com>; Fan Ni <fan.ni@samsung.com>;
>linux-cxl@vger.kernel.org; Peter Maydell <peter.maydell@linaro.org>;
>shiju.jose@huwei.com; qemu-devel@nongnu.org
>Cc: Linuxarm <linuxarm@huawei.com>
>Subject: [PATCH qemu] hw/cxl: Check for zero length features in
>cmd_features_set_feature()
>
>Zero length data for features doesn't make any sense so exclude that case =
early.
>This fixes the undefined behavior reported by coverity for a zero length
>memcpy().
>
>Resolves CID 1564900 and 1564901
>
>Reported-by: Peter Maydell <peter.maydell@linaro.org>
>Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>---
> hw/cxl/cxl-mailbox-utils.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
Tested-by: Shiju Jose <shiju.jose@huawei.com>

>diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c index
>2d4d62c454..ce9aa18364 100644
>--- a/hw/cxl/cxl-mailbox-utils.c
>+++ b/hw/cxl/cxl-mailbox-utils.c
>@@ -1288,6 +1288,10 @@ static CXLRetCode cmd_features_set_feature(const
>struct cxl_cmd *cmd,
>     set_feat_info->data_offset =3D hdr->offset;
>     bytes_to_copy =3D len_in - sizeof(CXLSetFeatureInHeader);
>
>+    if (bytes_to_copy =3D=3D 0) {
>+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>+    }
>+
>     if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
>         if (hdr->version !=3D CXL_MEMDEV_PS_SET_FEATURE_VERSION) {
>             return CXL_MBOX_UNSUPPORTED;
>--
>2.43.0
>

