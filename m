Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120D784DFE
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jul 2024 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599051; cv=fail; b=JieeH85n4o8dJzmLYeH3ahy8m3W5bt+TiXsMQjU5ASve9ceCtT2Q7Y/XYZMjfZPlXTpRF0E3kfdBa5FMyDZwvew0eHFIIoCavVQkrLLl9vcXiUXFATB8xGxzKqbqALjNl3me4WzLNHlpK/fJ4lwnY4vbJhySB3chvW8RfNGFXQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599051; c=relaxed/simple;
	bh=cJ2I5vu6z5S+bYiBLomplgpDtaksR3u3cLqknh5hMGo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NLo6+pp6yNUwnVlzY900YjZjn79EavZpOjyLmkAu1kjyyQ1q8UFyIp45cE8Iy58mz96lcozenDbJH6A58o2UEuBsExugED98pUdG0tsoNi7dq6nK25WpIUpWdKzf5ePGVvZcXIAo9ITRqLOWOTnpnjuM/ePzN9iR0ERb7lNCN1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=sgxxLGAK; arc=fail smtp.client-ip=68.232.159.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="sgxxLGAK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1720599047; x=1752135047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cJ2I5vu6z5S+bYiBLomplgpDtaksR3u3cLqknh5hMGo=;
  b=sgxxLGAKhYev9+/5T9Q2QPmYi/Te+LjEjWIcucZY8DA2VmyFwH4xqWD2
   MMDKTilISBfsR1zYYni8V//VpuvLfs5DUDKcRrHwt+78BxNmCfEQCauAD
   q95n/bj0pZQjRlSPKxw6tQpxpMzzgz2C84rGCHk88NVmD4fqIuRH0ECxN
   /qB7DmRtfhicmI6qz+8I8yg7Blhe5gA4aVMvRDr0KzTFP63ZteEZI0Eo3
   WAWr0Y1/angH5+XXR60P4Ut47Kjq6VUE/EaKecGBs0P6WIOoFY9ZSx8oc
   3ZbVeo4YU9RV+6aHts8t+fHucRue7M8d4tnI+zTTc8wuPbYh17R5UQ1+q
   g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="124895915"
X-IronPort-AV: E=Sophos;i="6.09,197,1716217200"; 
   d="scan'208";a="124895915"
Received: from mail-japaneastazlp17011030.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.30])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 17:10:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VH30NJJcgJvKvryXBRy1hfh+JrGVwBApLmu6JRa/eA2p/yek2vVByW8F8ujmIiDmFUU1CTBS+kMAa5w68i9KT0Euo0Z638/kiSOWEfV5vuAYc+AB4FdbAfCTCqFTh82cRceTxTnoEqgqC7vN5yiAdoQGLs3HPDrjDmgXUKq9jrdIOe2/Byqg/1wukB+ZiBQKB48O+eOQunCVrNTGWHC8TUeX1V5ErBAQOpqXhbZsNCIuLGpHLuaV5jhyTEzTEl3y3RUUym/YcML7w5u53ZH6Q5WdrRRwFVFgLjvLRg3NtxlhtWBqrFm20Te2kzvj6mZLiqSTWtqKFzB05SDQg8z5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+wJjtf0o2INEiQx4/0GeTrgcvp6GnyY/2sRUfjD1s8=;
 b=RAVvILtQCpgikq4eXW6XfcBgT8aoAeJtiPWGSew8DBB2Ouhlqbv9eUF64hJKGrm7ikk4h7VtbblGBIKHVocgSRORAhwyZ4gT+pdXgz8rwmpVn4uR34LqomwPmFCrIuYJvhyeHbr7Q+RETwdABF2XZJtHRW0MAak9cqdrMIJM6C5FL0KkA9M3k3bX6ShPe6kDWB2N5zqgPstSWmI12+Ff+zKU14YTitGmR/YvTqSck7FwBlOjo0+DZ4+ASWcM31vhd0/NBj3+MaCGiXYojb2BLaXjgSM+jl8jcfwlYlKHiEUZir/Kq1VWfJTKQJYaNCER0Pzn6l/2uSV+SkDWViH5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TYCPR01MB10260.jpnprd01.prod.outlook.com (2603:1096:400:1d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 08:10:35 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%5]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 08:10:35 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>, "mj@ucw.cz" <mj@ucw.cz>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v14 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Thread-Topic: [PATCH v14 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Thread-Index: AQHawTfJhzFq8ttb2ECavj+/vZskubHvYWCAgAA7ZICAABMXMA==
Date: Wed, 10 Jul 2024 08:10:35 +0000
Message-ID:
 <OSAPR01MB71829D3B273E919435A1A86BBAA42@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240618042941.96893-1-kobayashi.da-06@fujitsu.com>
 <20240618042941.96893-2-kobayashi.da-06@fujitsu.com>
 <668df392f2036_102cc2949a@dwillia2-xfh.jf.intel.com.notmuch>
 <668e256583728_6de229444@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To:
 <668e256583728_6de229444@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=b809dbf0-8ab9-4373-8189-971291089639;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-07-10T07:18:09Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TYCPR01MB10260:EE_
x-ms-office365-filtering-correlation-id: 8bdae449-91cb-460d-1571-08dca0b7c68a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?RHRTMndMbFl1OFVnUThDRFBTY0wwVFoyY2VNaS93OTJMU29aOHpCbk9J?=
 =?iso-2022-jp?B?NStXZmZCeHdsa1RRZU1FdDhjUnY0OHBoWkdVT3B5ajRGMFAvTWFvcDRT?=
 =?iso-2022-jp?B?bFNPeTdBb25ONEdJVzZqdzRmNTFab3J0TElHZEx5bVcyTFZFRTR5VjJM?=
 =?iso-2022-jp?B?eVAyZitqTmNudE1xd1NSa2lvVExOOEg2c1VrazFJZE5ua1lJaTUrcm5x?=
 =?iso-2022-jp?B?eFlWWDhsaU9XZm5Xa1lPRUJOa05VVDdyeHFQRkV0RVAxYjAxdXhLdEZJ?=
 =?iso-2022-jp?B?TmEwcC81ZW5hU1cyRXhpMVl2QVBDWVFmSER5dkNieXhWY3c0SDdLRXB2?=
 =?iso-2022-jp?B?QVV0ZjQrZVR4Q0daR2RVYjdCdzhrV1hFS05UR1hCKytXRXB5YnM2Nzdn?=
 =?iso-2022-jp?B?aUx0SnphZ3RJS3JUdmhMY3k5Z2hjWVFrc2d4Unlzc2pPZzBKODJkSE5y?=
 =?iso-2022-jp?B?ZGRFL1BIK0RnejdWWXJYNVdpeFRyNUg0blFtSVBmZmZsbVBHbnRCcG5D?=
 =?iso-2022-jp?B?bExGWkJVWlN5VEsvNGRwdHpKQWNNZHlWNnphRTh3NVI5czUwRGZIZlNX?=
 =?iso-2022-jp?B?OVphWDA4N2lXTGJKcTczNWtlVENPQUNZRUE3RHlwTU5FZzN1RWhmQnlj?=
 =?iso-2022-jp?B?UTVFVFJuNnhUaXdBOU9SNDl5VXJGeHJHNERldTRxT1ROcjRETWV3K1Ja?=
 =?iso-2022-jp?B?ZDI4RXBoWmorY2M1RjRsYlZEWmcrbUlHL2tDRThIN1VFd2VKQW5SN29s?=
 =?iso-2022-jp?B?TVNOdlRyZys2WENtOHQ1MkxpS1Z0T1JhaEd6dEh3Q1d1QnoyL1ZJdWhO?=
 =?iso-2022-jp?B?YjJCcHdPS0VMSTZNcEFuaFdOVWU3ejFPZUNlKzlTb2tlMit3N093ZGpi?=
 =?iso-2022-jp?B?RElYK0F1N0h6ZG9aRENFQkhWVmcvQTNERmdlbmhsVWlrN2JBczBsUUdy?=
 =?iso-2022-jp?B?ZWluWkZFcXJtSDArQXlrWng3eENuM204WWpxOVhHa25hekRmU0VUa3ls?=
 =?iso-2022-jp?B?UUhVNXhUT1hnUHhPWSs5UVdyc2EyUUdqS2lUMFVJVlZaTkE2b3hXQUVz?=
 =?iso-2022-jp?B?YmtlWWFKNTBWanJMMzBSLzZsUWM1NjhIUmZCQmZTODNuUDJRQnB2b3Zu?=
 =?iso-2022-jp?B?RW9Bd2tvNmgvMTBxSEp1dDhwaWdBbGc0SmJhTjZLcElreGZDdnlUdTJ0?=
 =?iso-2022-jp?B?Y3VIRUhHTTlSVHhiS0lrdGRGMkJKNXRrL1MzZWxnQ3RUKy8wYjhOTms2?=
 =?iso-2022-jp?B?c0QzSFY1TDN2Vjk4UmkrV1BJbDV0aFJiNG1abEdablBQMUk3Q1dPMk5I?=
 =?iso-2022-jp?B?M3BGZHVyRXRFVkdJS3hsNFkrN0p3T0RwdmVlTlpsbktrbXF6Tm93ZHZv?=
 =?iso-2022-jp?B?NDJZV21lWkFmemZFaHJvQVovQTlkL3hhWmxXdldocG05TEljVEpVVjlD?=
 =?iso-2022-jp?B?QThDYmxjRU1KWkczd2lpOUVDTXRudUZJQ0t5YXVsbVMrWndWcFJWU1d3?=
 =?iso-2022-jp?B?akx0bGxUQkI5RkNQRGl2VGdLcG5zUk9TeS84ekx2dE1RdzhuRHhCdEpY?=
 =?iso-2022-jp?B?Tmp6V3ZUOFg0NkRRZWlWbWtvRHhlSHRlVWREYkxaL2h5cThDWFhLOW5a?=
 =?iso-2022-jp?B?RldFM3hCTTNFMi9oRFFFVmdxditnY1lUbVp4cTdZVG01WEJhTE00YUhx?=
 =?iso-2022-jp?B?SG8xanhxSks2Tzl2VmFYY1lWQzFzdzFQa0pqN0U4M0VvU1B1a0w0MFZi?=
 =?iso-2022-jp?B?eDZpMkhJZ3RCWEVJc1VEckpTRVAzNEhyOW5mUlNOZWEzSVJ4bkFmRHVl?=
 =?iso-2022-jp?B?Yi9vWmJ4S1dZbjh6UzZlenU0dW1HcmdEMFRUYTdyN245TEVnUGh4dzd5?=
 =?iso-2022-jp?B?bmZUbUZlbStLTmtVNVdnKzJEV1RZMEwyMjNKSFdBSmdDakJQZ1drU2dN?=
 =?iso-2022-jp?B?NHkzOFZ2WVhqSWNnOXJ1REhjaHRNdTFZdVkrSE9ieFhMSFB4VnE2Smxx?=
 =?iso-2022-jp?B?ZXhvc2NtbU5YZXBlVW01eU5ML1lkVFliUlBuYi9PMkgvUjRmeU5LVlND?=
 =?iso-2022-jp?B?cHBsSGpoL0NSYXFKZFV0WWVxamVsQ0U9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?eEVTa0N3UUxqVzhPTEFvTURjN3c5emZPaHNwSFczMUdUWUJ3VkY0amlT?=
 =?iso-2022-jp?B?SVE0bExIeWZ3cHllVElZblBsQnZLYndpKzA3bm9tYjV6bmVsZ1BvMjBB?=
 =?iso-2022-jp?B?Skt5VFg1Mm53QTN5ZkZIM1Rid2VvRi91VDlrVlBza3Q2UzN4cDNaWmo0?=
 =?iso-2022-jp?B?TFBPa1d2cWd4YS9MZVMwUmZtV2NrbFkvODZmOTRnNmFtUDJnOEZ3UVp0?=
 =?iso-2022-jp?B?Q2J4YUl5dTE0MEY1cWN3UUZBLytmREo2U2Q5dDBzaVhEZXN1SktlakdQ?=
 =?iso-2022-jp?B?cjcwWkhIaVQzSHowbWNPNjJrNUhUV1dvbjQ0V1VSRDcya0hnb2EzZk9L?=
 =?iso-2022-jp?B?Y3N4a0pWbGZubW9QWXMwcU1HcGF6UTV3S3BkTGc2ZCtKbjRHTUpYSGM0?=
 =?iso-2022-jp?B?QVRnZGtaZ2xzRDVURmk5RlJSNW1pZWtMRVhFa1lya1lMOXEvaFJ2ZTF5?=
 =?iso-2022-jp?B?TGs3QVJUbnpJMURpNWdtdFBDU1paQTQ2UFVGNnkxdkM4djJxOFdHU1c1?=
 =?iso-2022-jp?B?MC9vYnFUQmZGM3RHZ1pCQmI0ODJ1bVd4cmVpeE9PcUUxcmZKaFVBV0Fv?=
 =?iso-2022-jp?B?bllXNjdEWGtWRzlGVGVWMmtSTlhUTytFNzR6MmJpWit0M3NRQk9Beno0?=
 =?iso-2022-jp?B?a3prOVFac0J1RkVBUmx2UWNzVHVtdTduQ1g2WG13Y21INDJDZWc1M0o1?=
 =?iso-2022-jp?B?bjlBd3ZSUTU5S1NkQnU0NnZQZW9TeTFaM1lOV2pGY01MdEpwNEUwY0hi?=
 =?iso-2022-jp?B?ZVhHWWNFbkk4VmdhS3lnUm4rY2dNem1ZbjV4SjdSVnRHTkJ0czhDWGlI?=
 =?iso-2022-jp?B?WGlCMVl0b3lIb0tac2h5WklBMCtxZy84YlBJWjd6bVdSbFJWTitqY2lt?=
 =?iso-2022-jp?B?SWN4MzdnQk5Gci91bmphdjg5TWxwai8zYnJvaUNpZklqSFpyeVJJTjZm?=
 =?iso-2022-jp?B?Nzkrc25iSXduVEZpTmh2MjhvWDA4N1M0WHdMZkJPWmFialFGSkxrNE1o?=
 =?iso-2022-jp?B?RFMvVHh6TlBEalljSDAwV1drK0REbitIRnRNd1VCNnpwUUZtZzQ5V0Vi?=
 =?iso-2022-jp?B?L05XWkdEUXBsYm9TVmJjRTdxRXJ2SzRNZGRhQkFLb1lPOTRmbkdKVVRT?=
 =?iso-2022-jp?B?QktnMkN4S1V1c3A2UU9jdjhabkF5YVA0Mlp1dEhKeDdsOXBDWXUyaFJv?=
 =?iso-2022-jp?B?VVA0bm5POHQycmlWb3ZERC9CdDQ2ZStrMUpoczZrRzBZMXplVDNBLzdL?=
 =?iso-2022-jp?B?YnJrbUttbWllekxhaE05ajBzQjNBdUVoWWJDaVYvbmpVRUs0N0I1YXh2?=
 =?iso-2022-jp?B?aCtiTzl2dFQrd2xSbXlSb1ZnaFdITzhDYmE0V3hORU9TVWNOazRXbG9m?=
 =?iso-2022-jp?B?NWJCOFpXTFBmTzFVNitzcm5ubmNCZGk4S3NNV0JTYUVnaDlRQnhwaVFV?=
 =?iso-2022-jp?B?WnpBQVpDMXBNM3ByYmtMV2JKMUt3RW9iTVdRWTNyQXdUaERaU1ZBaE1U?=
 =?iso-2022-jp?B?NW5QV0JLTEZQR3o2Y0RKTjlWWFJyZDhhM1RiTmxZZUcvZzV2Q09hSlRv?=
 =?iso-2022-jp?B?aXIvbVArSmJBZzFUQVl0S0haRDNnZm90cVRiR3luWmt6SkV0MnFjS01G?=
 =?iso-2022-jp?B?dnRVYlhXODBRS2I4S29UNFR6QmNMMnljMnlSVmZOa3ZNeDd6Y3E3OEtQ?=
 =?iso-2022-jp?B?ZlFaRmROaEM2Sm5rNVE1T3plWHJHUlJwSDhsY0xoQlBMcm5oNVJyUUVo?=
 =?iso-2022-jp?B?UFpRbWdzd2NVdFJNWUJIUDY0ZW0xa3BKS1BCd3ZaWXpBRUt4YU9kVktU?=
 =?iso-2022-jp?B?bW1aRXhtbTVCb2lKZmdkWG9oZFVLL25malhocHMyTEtNSTcraHczRFo2?=
 =?iso-2022-jp?B?V0JyWFE0TjZVbndrUTM2VTBqb2hwcUk1Rm5lNm4wUnp0S1dhV2ZJNWow?=
 =?iso-2022-jp?B?djZaL3RHUlQreWV3VXVFMWEyYnBjWTFYMHh3bEFFMGgwQjVGcktXR0VL?=
 =?iso-2022-jp?B?NHl0d1Zka2RtZ1JSZ0F0TFp3blRGMHd2L3NwVHV5cE13b012d1RuTjBs?=
 =?iso-2022-jp?B?aDh3OHFFWUh0UVlBWWpzUGplNC9RU0lreG5UUjBsaUkveDZkc0ZjTTB5?=
 =?iso-2022-jp?B?TnBLSnlKTzBqK3NabHFrbEszWVRPMUIxM1gyMzRpOGJPZTZVR1VqVTlF?=
 =?iso-2022-jp?B?U2s5b3dYdDBBdVdocmJXVUtTWk40K1ZidDU4YmI4OEhJeWwxRWJEOU9k?=
 =?iso-2022-jp?B?cEpMdzhLckNiaEpPQlV3UGgzQ0N2eDdRL3ZGcnkxVE9laXlaRndZZGVV?=
 =?iso-2022-jp?B?ajBVTHdCblY1dVFlRUFoMmtwanYwS0ZHOVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5GzydUjCvKvV9L6aIxchQt4K+rPHtXTFoM2FXDep3PDfTyd7ifBk/Aq40x6vRc0Ng6wLgcXEmP+UJj+b6oJoR8Ra19paFCtP/kP4dgDvxJ3HdF8MRK1CkyOun42jULUPWIQJetgtVXJDDFr1oGqjsKJzG5HXYucW4UgeIa2E4JsGLjy0j7qemaPHjFVTdNr/QKUGU4dIta1eEPIDsipC2nbHYBsn4vVjtMzN1Y2VZbRBx6jDP+YpBibxNmSQ660KS9ZEtxtHRsa5xnH/l9FK494ZjCooPlpNhYS4i8Ae8u719PMX+7Vr0fqJSoQyhUuEI9A1EHhnDWPWF6up0NWLcEBTS6GDFxQ2M5DekwLiQGHSaUjwPxtauLn2F3c+JwivBfeFtDtJNKWd/0uE5l1RVPqptzhhVWxe6Y4Z/fn9n70Lc6x6QoTCkbX5NueMwCKRXe7CeKIaYJPcxW5c2t1F/aSzs3iepXx0ZHsNLPlYGSQP1YIo66W3uBeCqSNU9qZacC3/mDW/x1CgIFxB9MijczzmTATpGjkwx6Ma20R0ZdoYZrMrF2wxXCfVPkHpj90+fzuGNPM7Zp7HqC7W9rApEhczPaMk9u8FEA2GShizyRDLu9JbF1cUtFur0ew9sekZ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdae449-91cb-460d-1571-08dca0b7c68a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 08:10:35.0123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkINioTSykGsm3YlIGabeKtKZSn0YGDZImqczRrz9muiF2s/xbXBo7aoGGRXPpzokK/dwNSDzY3AtKbafhZMuL1s2oyTzkvFdPzfJY4gb4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10260

Dan Williams wrote:
> Dan Williams wrote:
> > Kobayashi,Daisuke wrote:
> > > Add rcd_pcie_cap and its initialization to cache the offset of cxl1.1
> > > device link status information. By caching it, avoid the walking
> > > memory map area to find the offset when output the register value.
> > >
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> > > ---
> > >  drivers/cxl/core/core.h |  6 ++++
> > >  drivers/cxl/core/regs.c | 61
> +++++++++++++++++++++++++++++++++++++++++
> > >  drivers/cxl/cxl.h       |  9 ++++++
> > >  drivers/cxl/pci.c       |  8 ++++--
> > >  4 files changed, 82 insertions(+), 2 deletions(-)
> > >
> [..]
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index 2ff361e756d6..bbc55732d6c1 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -512,11 +512,15 @@ static int cxl_pci_setup_regs(struct pci_dev
> *pdev, enum cxl_regloc_type type,
> > >  	 * is an RCH and try to extract the Component Registers from
> > >  	 * an RCRB.
> > >  	 */
> > > -	if (rc && type =3D=3D CXL_REGLOC_RBI_COMPONENT &&
> is_cxl_restricted(pdev))
> > > +	if (rc && type =3D=3D CXL_REGLOC_RBI_COMPONENT &&
> is_cxl_restricted(pdev)) {
> > >  		rc =3D cxl_rcrb_get_comp_regs(pdev, map);
> > > +		if (rc)
> > > +			return rc;
> > >
> > > -	if (rc)
> > > +		cxl_dport_map_rcd_linkcap(pdev);
> >
> [..]
> > Ugh, I was going to say copy what cxl_mem_probe() does around locking
> > endpoint_parent before attaching further ports, but that also appears t=
o
> > not handle the same race. I.e. I think cxl_mem_probe() needs a fix to d=
o
> > this as well. I will copy you on a proposed patch for that.
>=20
> I attempted to add the proper locking to keep cxl_dport live, but that
> runs into lockdep issues.
>=20
> So I think a better fix is rework dport lifetime to stay alive until the
> final put_device() of the port. In other words dport instances get added
> dynamically to the cxl_port, but only get destroyed after all port
> references are dropped. Then the @dport result from find_cxl_port() is
> not ephemeral.
>=20
> Given this is a latent bug that affects all current
> cxl_{mem,pci}_find_port() users, the planned fix is to just make dport
> lifetime longer, and that I will not have time to do that rework before
> v6.11 merge window, then I am ok for this lnkcap code to introduce
> another instance of the same bug.
>=20
> So, just make cxl_rcrb_get_comp_regs() and cxl_dport_map_rcd_linkcap()
> share the same port reference from one cxl_pci_find_port() call.

Thanks for checking.

I'd like to confirm my understanding of the comment. Are you suggesting tha=
t,
due to time constraints with the current patch, cxl_rcrb_get_comp_regs() an=
d
cxl_dport_map_rcd_linkcap() should share the same dport reference as a temp=
orary
workaround for the bug regarding the dport lifetime?

If that's what you mean, I think I can solve this problem by adding
"struct cxl_dport *dport" to the arguments of the two functions to share th=
e reference.
In this implementation, I'm planning to run cxl_pci_find_port() in cxl_rcrb=
_get_comp_regs()
and share the dport obtained there. You said that find requires a correspon=
ding put_device(),
but where is the correct place to run it in this case? Or is it better not =
to run it in this patch?
