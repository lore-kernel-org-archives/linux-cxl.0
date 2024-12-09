Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296E1221462
	for <linux-cxl@vger.kernel.org>; Mon,  9 Dec 2024 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733746856; cv=none; b=kZkkbw9y/xBhMlhbGsxHUf8in01k3ZViyJWeNp1XcBnoMgmq5i24kR0lzRLoMmj/Q7gt/IO5oZj/h7rTUWWaTXAHiKDfwHolQ6DQj6dn6+kp536Z+15b6xVFhr4fn96aLBzxN8CB8P3tmnPOMI8gcDqWFovKoBWGQ2hGg6QizbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733746856; c=relaxed/simple;
	bh=YozUf88vnYw6QymN3BC51bf//LYyOq1X/elIMl/GJjM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Td9out/lkZrhppxcCwe9hMw3mJ0vWbmdqFY7LTk4EcVkxUc98PSKh6WDbRoUWRcj6uUBVtlUuJdfAZHMI6bG7aODBPDnIPqmQZj9yr8jy0Pa5WU+v+sYAD7UcvDWlWQ/WrLmrXLLRu7pkBhDtyfGmDY4KV4XK+P/TZE1MhDMh1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y6LSN6nPSz6GC9G;
	Mon,  9 Dec 2024 20:16:20 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
	by mail.maildlp.com (Postfix) with ESMTPS id D5CC6140D1D;
	Mon,  9 Dec 2024 20:20:51 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 13:20:51 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 9 Dec 2024 13:20:51 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "ira.weiny@intel.com" <ira.weiny@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jgg@nvidia.com" <jgg@nvidia.com>
Subject: RE: [RFC PATCH v2 06/20] cxl/mbox: Add SET_FEATURE mailbox command
Thread-Topic: [RFC PATCH v2 06/20] cxl/mbox: Add SET_FEATURE mailbox command
Thread-Index: AQHbN6U/AWgAh0ECNEq/NQnVRdJ69bLYcQqAgAWC4mA=
Date: Mon, 9 Dec 2024 12:20:51 +0000
Message-ID: <fd15332539f844dca8445b3d199e7c43@huawei.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-7-dave.jiang@intel.com>
 <675249d57899e_25073294f4@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <675249d57899e_25073294f4@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
Content-Type: multipart/mixed;
	boundary="_002_fd15332539f844dca8445b3d199e7c43huaweicom_"
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--_002_fd15332539f844dca8445b3d199e7c43huaweicom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>-----Original Message-----
>From: Dan Williams <dan.j.williams@intel.com>
>Sent: 06 December 2024 00:48
>To: Dave Jiang <dave.jiang@intel.com>; linux-cxl@vger.kernel.org
>Cc: dan.j.williams@intel.com; ira.weiny@intel.com; vishal.l.verma@intel.co=
m;
>alison.schofield@intel.com; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave@stgolabs.net; jgg@nvidia.com; Shiju
>Jose <shiju.jose@huawei.com>
>Subject: Re: [RFC PATCH v2 06/20] cxl/mbox: Add SET_FEATURE mailbox
>command
>
>Dave Jiang wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add support for SET_FEATURE mailbox command.
>>
>> CXL spec 3.1 section 8.2.9.6 describes optional device specific features=
.
>> CXL devices supports features with changeable attributes.
>> The settings of a feature can be optionally modified using Set Feature
>> command.
>> CXL spec 3.1 section 8.2.9.6.3 describes Set Feature command.
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> This patch is not needed except for the opcode enumeration.
>> ---
>
>Same reaction as a the last patch.
>
>We can always circle back to add this on top if really necessary, but lets=
 keep
>this set on topic with the cover letter of enabling fwctl for features.

Hi Dan,=20

I  modified to cxl_set_feature(struct cxl_mailbox *cxl_mbox, ..) in the EDA=
C CXL features setup and tested fine.

Thanks,
Shiju

--_002_fd15332539f844dca8445b3d199e7c43huaweicom_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Mon, 09 Dec 2024 12:20:50 GMT";
	modification-date="Mon, 09 Dec 2024 12:20:50 GMT"

Received: from frapeml500005.china.huawei.com (7.182.85.13) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39 via Mailbox Transport; Fri, 6 Dec 2024 01:44:34 +0100
Received: from dggems705-chm.china.huawei.com (10.3.19.182) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 01:44:33 +0100
Received: from canpmsg-in (172.19.92.136) by dggems705-chm.china.huawei.com
 (10.3.19.182) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 6 Dec 2024 08:44:32 +0800
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by canpmsg-in (SkyGuard) with ESMTPS id 4Y4CFJ6p1gzLm2Z
	for <shiju.jose@huawei.com>; Fri,  6 Dec 2024 08:44:20 +0800 (CST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20620188426E
	for <shiju.jose@huawei.com>; Fri,  6 Dec 2024 00:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B52225D6;
	Fri,  6 Dec 2024 00:44:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1CE22334
	for <linux-cxl@vger.kernel.org>; Fri,  6 Dec 2024 00:44:25 +0000 (UTC)
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 16:44:25 -0800
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 16:44:25 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 16:44:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 16:44:25 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 16:44:25 -0800
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7054.namprd11.prod.outlook.com (2603:10b6:303:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Fri, 6 Dec
 2024 00:44:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 00:44:22 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jgg@nvidia.com" <jgg@nvidia.com>,
	Shiju Jose <shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 04/20] cxl/mbox: Add GET_FEATURE mailbox command
Thread-Topic: [RFC PATCH v2 04/20] cxl/mbox: Add GET_FEATURE mailbox command
Thread-Index: AQHbN6U//ktgkagc00iV+8Wv/2ktBLLYb+oA
Date: Fri, 6 Dec 2024 00:44:20 +0000
Message-ID: <675248e44c037_25073294f4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-5-dave.jiang@intel.com>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
In-Reply-To: <20241115212745.869552-5-dave.jiang@intel.com>
Content-Language: en-GB
X-MS-Exchange-Organization-AuthSource: dggems705-chm.china.huawei.com
X-MS-Has-Attach:
X-Auto-Response-Suppress: All
X-MS-Exchange-Organization-Network-Message-Id: 036af65b-d274-4f6e-66a8-08dd158f2689
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
x-ms-exchange-organization-originalclientipaddress: 172.19.92.136
x-ms-exchange-organization-originalserveripaddress: 10.3.19.182
x-ms-publictraffictype: Email
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8F8C68F4B1594B47971144A863BFB535@huawei.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

Dave Jiang wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
>
> Add support for GET_FEATURE mailbox command.
>
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> The settings of a feature can be retrieved using Get Feature command.
> CXL spec 3.1 section 8.2.9.6.2 describes Get Feature command.
>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> This patch is not needed by this series except the opcode enumeration.
> ---

Wait, then why is it included?

I would say fold the small bit that you need into the previous patch,
especially if we think that fwctl can cover all the "get feature" use
cases.

>  drivers/cxl/core/mbox.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 26 ++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 4ba56f3d5a65..f70bd7d28ff8 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -968,6 +968,47 @@ int cxl_get_supported_feature_entry(struct cxl_dev_s=
tate *cxlds, const uuid_t *f
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_get_supported_feature_entry, CXL);
>
> +size_t cxl_get_feature(struct cxl_dev_state *cxlds, const uuid_t feat_uu=
id,
> +                    enum cxl_get_feat_selection selection,
> +                    void *feat_out, size_t feat_out_size)
> +{
> +     struct cxl_mailbox *cxl_mbox =3D &cxlds->cxl_mbox;

cxlds is otherwise unused in this function, just pass in @cxl_mbox
directly.


--_002_fd15332539f844dca8445b3d199e7c43huaweicom_--
