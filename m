Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AF717993
	for <linux-cxl@vger.kernel.org>; Tue, 24 Sep 2024 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163371; cv=fail; b=g+gvoVDBo8Jg/K50BHCp/krja3wnA5fG647W8aIkEocN/ybY0MmkEEhs64sAbXoaaDRA4sTMDwuAV+jK+Px8o6Xl0B+YwD8+/zVPyd3eUz9r2XVqld9ls5pg29FmAp0QrDWFSCckB02GBFUJ2+ZxVZNTZ8xbOR9aXRseYgMyJzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163371; c=relaxed/simple;
	bh=u1GJQyWIJOSsqTUi39S4j7gturuTJU4HcWv0Q8hNYRE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uhWRPpsMW8H8mou61noojiJS5HbLAoZ5wQKagkaMamN9kBPsPIgjFqxGtulgVXvsGK3Jb91c0bMxPJ+ysw2IOf5GhsBc0z8DdLiBvvXvebDLFTL+nIb+xW+DTXa66/U8GTgxav6XNtZlfxararxevNtyLFyNR2X3SEscB694k18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=PHY2/DL3; arc=fail smtp.client-ip=68.232.152.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="PHY2/DL3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1727163368; x=1758699368;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u1GJQyWIJOSsqTUi39S4j7gturuTJU4HcWv0Q8hNYRE=;
  b=PHY2/DL37f+mtJeXi7+vkWlLGnnZD4r1U/tFH5fLaKqcsObpyevGCHGS
   xmIfyxsYmqQV2qPzfPraFe6relXHh1laVwLiXyB8n6ljv0k7HiGknUHXq
   equJPXcCynuNeLC8caRHtPukiflV6pbvajYWTHo3ZYM1K7r9r8lInbrOn
   +C31/pwfaneZ5JE245UkHZn5CiojYQt/v5yg4lupqL6eKuVF1wUvxo9Is
   PgLgHfKdriIMisYffkaihUzrMJOTmiGcYaAgsGSrgEMwMjTHYDocUoeGN
   mkkNgwY4NVqYoTxw0IYPBZpFpZHRjoZYhTU80fBg/gVyCJwCBTaNr4AmW
   w==;
X-CSE-ConnectionGUID: WMDbNqB6QHiTnQHv3wV0lQ==
X-CSE-MsgGUID: isiRKee0RJ+p0VlMq+tyig==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="42730963"
X-IronPort-AV: E=Sophos;i="6.10,253,1719846000"; 
   d="scan'208";a="42730963"
Received: from mail-japaneastazlp17011024.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.24])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 16:36:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4/7ErBkZGWu7zqhdGUesVer9g1yWNoHSkc49OB6il09b6/vkN7O74kMdxntBdESiW+LtbEp0CPtO7H9VTJDGyzDqK4kEofZiJno0tmX5nQ8Dn4+UoHJ1TNKGSYAuWTDe6w53kKAGTjwomRpDi3dbkicFvK6cS4qP1Gcj59Xli8RDzhngfbYlEDMEzHDYxOF0i68S/+z5OR3084uACpdT/r77cz2PgqQ/WZtL9zgi5xypWoJkjQsPdHPYJVHhS9bzXEzRV1WQq4n6jH5MAkzuqEBct62YwT0CuSDHOpIV4F09LfV4zODBrw05sjveYV76EkU8EuZK0sNw0/d8sB52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AboXZZK5uhqcv6hBToKqa8uFUANc6grmmVkt4Ggmyok=;
 b=DZmSErfSyrArn/IR/q147D+mI5wYRLOQwRzJTs7AslZQ80JOerIUxPqIIaxJvWoHhOzBGyBsjhQWNH9oNcSfvyX9idys1Viw83BNLab8UxgC+Xy22xfe6466gcYrPHP3S2OKb+6zy87nIsWISvO4BiJD5jOpov5VRLW+Sc+iEWwLJsDUd2BKNoaCHNy8k2DPANk7J4FD+nuQ3Tw4YhsQj7+lUIvh0eJjooL8nHv/nYJzcc0puCnGFua7BuADtXcjQtwtlOPPCaD8UrPxTgBs8EudEPFZ1ClbBXMcBw4zP8hMQt+0pNJMzxYkWHxYku+mtL20y3WwI1svDmyyCFw9OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TYWPR01MB8300.jpnprd01.prod.outlook.com (2603:1096:400:163::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 07:36:00 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%3]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 07:36:00 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC: "mj@ucw.cz" <mj@ucw.cz>
Subject: RE: [PATCH v17 0/2] Export cxl1.1 device link status register value
 to pci device sysfs.
Thread-Topic: [PATCH v17 0/2] Export cxl1.1 device link status register value
 to pci device sysfs.
Thread-Index: AQHa/azqdXMWHjCNtEO8fXwO2aK/wLJmqpZg
Date: Tue, 24 Sep 2024 07:36:00 +0000
Message-ID:
 <OSAPR01MB71827E711822FF4DD30C8A58BA682@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240903025915.270521-1-kobayashi.da-06@fujitsu.com>
In-Reply-To: <20240903025915.270521-1-kobayashi.da-06@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=True;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-09-24T07:35:59.989Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TYWPR01MB8300:EE_
x-ms-office365-filtering-correlation-id: 1c12a5cf-2b37-4389-24ce-08dcdc6b8957
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?Nmh3a204NUQ2cTVXMkVRQTRtSFZPc3N0TlBoeUhXK3BKcjBpNDNaTnFJ?=
 =?iso-2022-jp?B?a2czNzZKM1BCYk5Ia2NrbWIvaVU4YTN2dXRLeG52ZTNjTGlYL0lSdWM3?=
 =?iso-2022-jp?B?MDJ3VDZSM0VTdGRvcnlCMVFVeitHZXFEZlJPc2Mza3hOUGkwcmxuakE5?=
 =?iso-2022-jp?B?UVYrUjJmUW5NTzNNUW1DeEZIZkhuaWExV3JYZXEyLzFIM3BGai8vUFpW?=
 =?iso-2022-jp?B?OUw0ZU5KdjVWRUJxZVNVd1UvaEtiWjFxYWErN1pkcWt5MzF6bXh5VFVs?=
 =?iso-2022-jp?B?ay94S3ZiY24wYkdsWDV4a05seVNpWHpxcitWSUtRTmZJR2pNR1dNRWRz?=
 =?iso-2022-jp?B?Mlc5enZTM2tPK2x3VE9WTjFzMWpqSGZDb1VvRDZQV2J3M1YxOVdkdUdl?=
 =?iso-2022-jp?B?RGxsS3daVnJVb0N5UHpOU3kwWUZhaWU2QnVIaC8rMGIzWVRKQjBWZWY5?=
 =?iso-2022-jp?B?MnhvVjZ0RXVKMWgrVkMrTURSQnpzby82RTdnTkwvblhtQU5VRDFvYzRn?=
 =?iso-2022-jp?B?L29oS2lpNEFOT1BMN0IrZ0pHQ3RnWmxiSXl2OXdsR0JyTmI2S1N2blRo?=
 =?iso-2022-jp?B?dUR4UGtsTk9LbjZaLzBtN1hsOTZFdHJBSmV6WGNxT3Z6L2d3Wm9mNmdt?=
 =?iso-2022-jp?B?L1I0bVZMTjJVSjhoOFJJRzVObDNBdmpWWWlKOEZ3ZUZHSkxUekErbWNm?=
 =?iso-2022-jp?B?bE5JZktvU0VmTGg2MGFpOTdmTjg0WllpeTVmNytPaHVITDRhR2lRbXZK?=
 =?iso-2022-jp?B?STQ0V0lFZDRyV1NIZTF3Y3RvYlZEdFhpNHZja2RES1Y0a0UxSnNQRVFi?=
 =?iso-2022-jp?B?ajB3bEJoQjR4MldpeDRWM0xvTTFLcHVQS2xnTDdlRUdZejJobThoQVVF?=
 =?iso-2022-jp?B?ODllSmJHK2RhcW5TaFYySzBTekZDNjZsa1RhNzFrUm9PRU02YTNKb3FZ?=
 =?iso-2022-jp?B?V1d6NlluQTFTZnlPUFkrb0l3MlY1NTJWWVJXdndRNnNzNmxHOHZTM3hu?=
 =?iso-2022-jp?B?a1ZHellLVlF3N2YyWXBWRUZmeld1S1Y0RXpNazJwcGJqRmlkMlErK3N1?=
 =?iso-2022-jp?B?REp4RzUrbmFvUXMxcHNtTTNjeHRpUE5TQ2lya1RYb283NmpYN2FlazBI?=
 =?iso-2022-jp?B?SFZtaXEwLytGeFgyZWg5dHBlRDNVcHJUZjR2NEZ0WWV1cGpnbEhGdko0?=
 =?iso-2022-jp?B?UFZjMHdHd29GOThYR2FUZnJxWjg3Z3BiTlVqTnFYeDZOM2hMQTVDc1VQ?=
 =?iso-2022-jp?B?MWY2bFJNZFQxSHc2WUwrYTU3VnR0c3BkZ0dEUGplR1ZOaXdSM1RRRXpF?=
 =?iso-2022-jp?B?VnRNS0l1am1OejZJU0YvY1lmRkpmR3lMN0Y2TytIc2RIajI0bUIxTi94?=
 =?iso-2022-jp?B?dW1nVTdJVVFCTktRSnUvUDdnSW1qNG9xQTJQaVdVWUl4cU4welBHRjRY?=
 =?iso-2022-jp?B?dno5ejU4cmJQRTVDdml6aG9CbDd5c2k5WFJtRjJvRitYTG5kOG1ZRFZu?=
 =?iso-2022-jp?B?SFpUZDJxNmtPVWRHNzZDV08ybk11YVhGUHorSTRkYzRraG5Xckt4K09Y?=
 =?iso-2022-jp?B?UXBrVWU0cy9RTFBBQkR4aE1EQldXbWJxYUZHaEZPRlB1ck1nZ3N0OUJ6?=
 =?iso-2022-jp?B?aWpYQVlqWmNlNFpzNXdNOUFxOFViS2RaRUhGYkF3dWZDb1l5SG9rVGpT?=
 =?iso-2022-jp?B?NVVseGNLaitkTHdyUi9iUDc1eDl0OVQ5cDRHWVR5S1pMUGhRYnBXZ2ow?=
 =?iso-2022-jp?B?MjNIQi9kZUoxVDFScEJwZllDdVFOcmtJWlJWNm53TFpQcy9IUUFjUDh1?=
 =?iso-2022-jp?B?Yjh6bWZ1V2xGY1IyRTY5bW1GRm1XUHhKb0FGWTdjTjBhSlQ0WXhaUFkx?=
 =?iso-2022-jp?B?ZHVlK2UyVkxNN0RHOXVpU2lIU0RxbG9DR0F3V3NTdXExSUZvOTZrQlJD?=
 =?iso-2022-jp?B?TTBxdDY4ZWsvL05WS3JNSHJkTWF5c2F1S3h5VjRONnRDQXpseUkwZ25q?=
 =?iso-2022-jp?B?MTFRdVUveC9OMUkvSUVuZE9SYUw3czRlTk5FaXdNcWYzaTlKTndQNmhI?=
 =?iso-2022-jp?B?aVoweGRxNUIyM0dRWStsR2YydVNRRXE2dW1SZzZUM2pQN1NHaDNBcGtX?=
 =?iso-2022-jp?B?VVM=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?a1BXM3NiaW5FUGJIMGZQZVkzQnpaYmNVQk05UWhMY25tZmhJNzRpYVR5?=
 =?iso-2022-jp?B?eVFDajlXWG1sVFpBb2tXaGJmOEV3TWF5V1FRSkNrRERNS0M4TWlnTXNX?=
 =?iso-2022-jp?B?S2xmYmQxTGxRL0FtcUszbGE1UEFLNHpMYUgzNy9ic1NGRnJ2K2RLK29R?=
 =?iso-2022-jp?B?SlM2MkJvNFQ2NStNeU5nNzIrRGhxdXYrS1NBM3ZuK1FrL2R3RUMwZGdW?=
 =?iso-2022-jp?B?SjhHckhlKzJ2aWhCVHhJcUVvVHd0MEZyTUx2SDU1aGNsYVZ2NFBHaDJS?=
 =?iso-2022-jp?B?MUxFYXl4QkZsOHBoeVdGbzFUMWgrZTJIdkhmVkdMYU9TRm1RRXZCV01a?=
 =?iso-2022-jp?B?YmVkWnFlY2RrMEd4VjdqQmpZY24rZWZEbkoxRWlKTEtoY2xmaGFjdmtK?=
 =?iso-2022-jp?B?V1hNMzM2TjlnR3BjSVFGY1FQVUdManZ1czJ5YWhKVkZhUnRlRkxUZ2w0?=
 =?iso-2022-jp?B?bmFWNFBFNVI5d1g4RTE5Q1JzeXMvdkF1WVFPZk9EZ3FRUzVZRXhDUFJ1?=
 =?iso-2022-jp?B?VTFyK0tMT3d6azh2OUtkN3RTZ04vYlNqS3plWmMya292K3hxRk5QMkxS?=
 =?iso-2022-jp?B?QVpUVWxDQ0tZNjFiMzF6bG9PbzJIeG1SaGRiVVdCT2F1UmN2MXUrb25s?=
 =?iso-2022-jp?B?cmt5bzljVjhVV2xCTTlqdU9Pay9zWnMwcDlHd09kS0ZuSzR3WUlZbFhQ?=
 =?iso-2022-jp?B?NldWYlkyeG9zMXljQlpuSXdtbHphL1B6RjlIdWJtZFhGRlhqekNzS3gv?=
 =?iso-2022-jp?B?WjR6RnhMRm45NHoxcG5GQTlOcytQTXp3U0tOd0VJTGpEVm5WNUNPTms0?=
 =?iso-2022-jp?B?U0ROYW15dDJTVHVGVSswaVFYV2EwOW5jbHhwOG5xaTdsUU5KK1NFV2RQ?=
 =?iso-2022-jp?B?WGpTR3BsR0FSbXp2Um9KSERRVUlUSWQ3Mk90TFM4UTFsNkhuNGQ2ck5D?=
 =?iso-2022-jp?B?MUF6bEUwOW9rY0ZMWkZ4NDlJWXN0amozMG9tVjd4QlFQdUlaODI4czl4?=
 =?iso-2022-jp?B?R0pDRVBkZFZxdjlWRGhFbldtbGF1UWlqUFFuMG1COTEvem5NRnlIQVMw?=
 =?iso-2022-jp?B?RG52WGdsVm1lSGVQVzRUZm9Pc2hKaE1qcExmdWVMVXB3SWdqeWdWanVz?=
 =?iso-2022-jp?B?aCtUa0dLZ3lLbVcxQy9jZU9wcDBpRFdobm5nZXpOUGJVQlZ4VmlrN2Rq?=
 =?iso-2022-jp?B?YTVSL0hFNUdacXkrNVVCSTRWRU5KM3NPS1kzbmllbXZYTEovUkpIK0Jn?=
 =?iso-2022-jp?B?RkxacUtVaitwU0I1Nk4ydjF5ZGRFUk5zR3V6NFQ4NDNBYmU4bDRYRVlL?=
 =?iso-2022-jp?B?K1g2dmdJVG9sajVuKzVtY1FINGxycS81UTJlMk9KdlA5VTVGcnZ2QXBN?=
 =?iso-2022-jp?B?WnZvK1N4a2FYQTBBZlJ5REExUGJZYVp2cTJ1R3NqVmI0V1FDa0JZT05T?=
 =?iso-2022-jp?B?YlBHTW52RkQ2cTRIaEFraXhFTGNRV056ZTNFMFYyb2NLRHc4azc2b01Q?=
 =?iso-2022-jp?B?cmNZVnltaHVtNnp1QzVYZElLTktQbEl4NFphTXo5U1lsRDVMVVdnZTNt?=
 =?iso-2022-jp?B?eDhCaXhMTzNkTHBEQW0vbmlZVm5yVE8rMUNlZEhNV3FBMEdGSlozaGpH?=
 =?iso-2022-jp?B?UUl0SW1MWUg4VXI1MnJBb2FaelFvb2tjL0RzdkFmSi9NSm5DckpJV3lK?=
 =?iso-2022-jp?B?cmFTSEhLalFnVXEvdXlwQWNVaUNrMThFV3JBaDhKTy9zNnlPY3N4aXJa?=
 =?iso-2022-jp?B?b0RYOUpGbjBEQ05kOVFhMjBOQjFLV0ZvaWVzVkNPdFk5K2VQNnA2aGdl?=
 =?iso-2022-jp?B?a3ZsVkZMUkR4QzMrTlZOQUMwTlY5V1hyNGVxRHJ1M0YyYWh3aEl4b2hY?=
 =?iso-2022-jp?B?dzVHeE5zK0h6VExWNUkyWCttNzR4ek1MQmNreTJtMmxnUXpRckp3Vjlq?=
 =?iso-2022-jp?B?WlN0YTFLc2RCR3ZhcnBGQ3ZEN2pIY2toMGs5bW1qUlZLdlVRV0JtUnRk?=
 =?iso-2022-jp?B?dEhhVTdaN0x4RkROZzR2NzZKcGFjYUVtTlJYVlF4Z3QrS1YxbkU0ZnN4?=
 =?iso-2022-jp?B?dE43SUpNc2Z3ZnhqT3E3aDR3OCtTVzVjWFcva0Z3STNhUjQ5bitWRU8w?=
 =?iso-2022-jp?B?Ymg2eXhtTmZSQkdOeTE5Q3ptYjRpRG1wVkt0S2tsYkZTSFh4OE0yTlpy?=
 =?iso-2022-jp?B?Yys1amJ3ekpvb3p6L3gvQ053NDNEcCtRLzJTUm01MjM1b21NUnJ6dEFJ?=
 =?iso-2022-jp?B?cDVOREp2Y2RaTlZ3RDVzWlZPTTlDNThFUTFUSS9IcFVTY0hFNXp4QTg5?=
 =?iso-2022-jp?B?RkVDR2lFNTRBTmVOdU5neFhtc0VpQXVBR1E9PQ==?=
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
	rDGzrHPOtHvdPaPVRAgwdd5/Rbx4JaDK5NEaDU4Jy3U8r1JjnmNRcCDhl/MlJghromz/LjwH4ZEcyNjwz5BS8m4E7cxkZt9mfm2n7tZWvLb4crixf0IR5Gd5EwHlP3mkKgh0/JD4/uy279FOhIAHjIHQO6PEVfNe0p1tdiVGcliksrkUef27vEAfxeO+ir5WlSs+iCrpRWRjVokhqCh7Oa7Mf6WGuotU8Qaye1Ed1RvdkpGgxkGf5d5xrpzC2UvuBffJspDW261aWZXWQFmn5PklH6neGMmzH2w2KkeGGEpVfuSDORKRwdxxC/xI9+vAMgEyOrPTxzUXkUVTrjz6VyQDAvq/7XnFb47dkvT302aVQFjil1L4Eyrq0itxGm1m6LI4CqbrfOYvIvcYyeHUJewZ2P+QNFpAjx3QKML3i2Iwn+d47/pfN8XfDPmwEpxEZvI7oc65WOeNKsk8dhDYZ3B6GbpuxlMIHCMMU7cRz4To6QjvzreBxfvrNX4ltX0uAN9lLp6VMcfGJDcLGCsEsi9PUPFTkFJrFgmXG73ILV3PGhGF+J8gg0d1aJzSAWvYpaqEmhFJZgYHnYKPAtXUNNMlBFnVB4crWwp9oPjxNSkiBYBN3zzsieCCR9ljNEAH
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c12a5cf-2b37-4389-24ce-08dcdc6b8957
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 07:36:00.3557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t2FHDFHuyi5snuXvWI8Jq2wg0tvcdSKxP2X5IAb7SO7QdXJlKtDIcG8ICzBUSQmSgGL+qiOa2OcTZZoQrdT6Q8z7CXbNp6Ro6GMxQ4530A8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8300

Hi, Dan. Could you please review this patch?=0A=
I think I've fixed the issues you mentioned.=0A=
=0A=
Thank you.=0A=
=0A=
Kobayashi Daisuke wrote:=0A=
> Subject: [PATCH v17 0/2] Export cxl1.1 device link status register value =
to pci=0A=
> device sysfs.=0A=
> =0A=
> CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards, the l=
ink=0A=
> status can be output in the same way as traditional PCIe.=0A=
> However, unlike devices from CXL2.0 onwards, CXL1.1 requires a different=
=0A=
> method to obtain the link status from traditional PCIe.=0A=
> This is because the link status of the CXL1.1 device is not mapped in the=
=0A=
> configuration space (as per cxl3.0 specification 8.1).=0A=
> Instead, the configuration space containing the link status is mapped to =
the=0A=
> memory mapped register region (as per cxl3.0 specification 8.2, Table 8-1=
8).=0A=
> Therefore, the current lspci has a problem where it does not display the =
link=0A=
> status of the CXL1.1 device.=0A=
> Solve these issues with sysfs attributes to export the status registers h=
idden in=0A=
> the RCRB.=0A=
> =0A=
> The procedure is as follows:=0A=
> First, obtain the RCRB address within the cxl driver, then access the=0A=
> configuration space. Next, output the link status information from the=0A=
> configuration space to sysfs. Ultimately, the expectation is that this sy=
sfs file=0A=
> will be consumed by PCI user tools to utilize link status information.=0A=
> =0A=
> This patch series relies on the functions defined in the following patche=
s.=0A=
> https://lore.kernel.org/linux-cxl/20240830013138.2256244-1-ming4.li@intel=
.c=0A=
> om/=0A=
> =0A=
> Changes=0A=
> v1[1] -> v2:=0A=
> - Modified to perform rcrb access within the CXL driver.=0A=
> - Added new attributes to the sysfs of the PCI device.=0A=
> - Output the link status information to the sysfs of the PCI device.=0A=
> - Retrieve information from sysfs as the source when displaying informati=
on in=0A=
> lspci.=0A=
> =0A=
> v2[2] -> v3:=0A=
> - Fix unnecessary initialization and wrong types (Bjohn).=0A=
> - Create a helper function for getting a PCIe capability offset (Bjohn).=
=0A=
> - Move platform-specific implementation to the lib directory in pciutils=
=0A=
> (Martin).=0A=
> =0A=
> v3[3] -> v4:=0A=
> - RCRB register values are read once and cached.=0A=
> - Added a new attribute to the sysfs of the PCI device.=0A=
> - Separate lspci implementation from this patch.=0A=
> =0A=
> v4[4] -> v5:=0A=
> - Use macros for bitwise operations=0A=
> - Fix RCRB access to use cxl_memdev=0A=
> =0A=
> v5[5] -> v6:=0A=
> - Add and use masks for RCRB register values=0A=
> =0A=
> v6[6] -> v7:=0A=
> - Fix comments on white space inline=0A=
> =0A=
> v7[7] -> v8:=0A=
> - Change the cache value to offset=0A=
> - Access memory map area in rcd_*_show() functions=0A=
> =0A=
> v8[8] -> v9:=0A=
> - Map the pcie cap in for all the time the driver is bound to the device.=
=0A=
> - Add mapping the pcie cap in cxl_rcd_component_reg_phys().=0A=
> =0A=
> v9[9] -> v10:=0A=
> - Change a utility function for getting PCIe capability.=0A=
> - Fix tab alignment issue, error handling, and apply suggestions from Jon=
athan.=0A=
> =0A=
> v10[10] -> v11:=0A=
> - Add functions to have one function do only one thing.=0A=
> - Add a size parameter to utility function arguments and consolidated the=
m into=0A=
> one.=0A=
> =0A=
> v11[11] -> v12:=0A=
> - Fix the error handling in cxl_pci_setup_regs().=0A=
> - Fix and clean up some details.=0A=
> =0A=
> v12[12] -> v13:=0A=
> - Fix and clean up some details.=0A=
> =0A=
> v13[13] -> v14:=0A=
> - Fix and clean up some details.=0A=
> =0A=
> v14[14] -> v15:=0A=
> - Change dport lookup to be done only once.=0A=
> - Fix the visibility of cxl_rcrb_to_linkcap().=0A=
> =0A=
> v15[15] -> v16:=0A=
> - Fix the port leak bug by introduce a new scope-based-free handler=0A=
> - Improve the variable names.=0A=
> =0A=
> v16[16] -> v17:=0A=
> - Change used function for making struct cxl_port *port=0A=
> =0A=
> [1]=0A=
> https://lore.kernel.org/linux-cxl/20231220050738.178481-1-kobayashi.da-06=
=0A=
> @fujitsu.com/=0A=
> [2]=0A=
> https://lore.kernel.org/linux-cxl/20240227083313.87699-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [3]=0A=
> https://lore.kernel.org/linux-cxl/20240312080559.14904-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [4]=0A=
> https://lore.kernel.org/linux-cxl/20240409073528.13214-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [5]=0A=
> https://lore.kernel.org/linux-cxl/20240412070715.16160-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [6]=0A=
> https://lore.kernel.org/linux-cxl/20240424050102.26788-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [7]=0A=
> https://lore.kernel.org/linux-cxl/20240510073710.98953-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [8]=0A=
> https://lore.kernel.org/linux-cxl/20240606074814.5633-1-kobayashi.da-06@f=
=0A=
> ujitsu.com/=0A=
> [9]=0A=
> https://lore.kernel.org/linux-cxl/20240610082222.22772-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [10]=0A=
> https://lore.kernel.org/linux-cxl/20240611055254.61203-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [11]=0A=
> https://lore.kernel.org/linux-cxl/20240612075940.92500-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [12]=0A=
> https://lore.kernel.org/linux-cxl/20240614045611.58658-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [13]=0A=
> https://lore.kernel.org/linux-cxl/20240617043702.62028-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [14]=0A=
> https://lore.kernel.org/linux-cxl/20240618042941.96893-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [15]=0A=
> https://lore.kernel.org/linux-cxl/20240716042540.89639-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [16]=0A=
> https://lore.kernel.org/linux-cxl/20240815005510.220835-1-kobayashi.da-06=
=0A=
> @fujitsu.com/=0A=
> =0A=
> Kobayashi,Daisuke (2):=0A=
>   cxl/core/regs: Add rcd_pcie_cap initialization=0A=
>   cxl/pci: Add sysfs attribute for CXL 1.1 device link status=0A=
> =0A=
>  drivers/cxl/core/core.h |   5 ++=0A=
>  drivers/cxl/core/regs.c |  56 ++++++++++++++++++++=0A=
>  drivers/cxl/cxl.h       |   9 ++++=0A=
>  drivers/cxl/pci.c       | 110=0A=
> +++++++++++++++++++++++++++++++++++-----=0A=
>  4 files changed, 167 insertions(+), 13 deletions(-)=0A=
> =0A=
> --=0A=
> 2.45.0=0A=
=0A=
