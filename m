Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0605F29422
	for <linux-cxl@vger.kernel.org>; Fri, 24 May 2024 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542162; cv=fail; b=fGvfMAmISONRG2g4wYneVevcXoEuwG1aJ9BoKf/Tmr9UWKdDxWyvbTeCOxPb9ekSRa6CWsZyTsSjzDvIUfeWeYzB7CiIZtqrVbnfU8IWtoA3iqM5YTk3Z0agU5Huh2Ms6/xGR1GQdOulEGYOs/G41Kh0fPjx71fZsIZ3m1dkXCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542162; c=relaxed/simple;
	bh=FmOBrHhfl1bfltFQtTWdUGL3HJ+TD19KbF1QLQAJ0NE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kS4HrwIeWAAww3f0BmgLFQBfsJT7IM9jts7mU9M6dSK4NhbWwmeETyQ6WvBy5PkWvHBmyOPRCbsvqts2zs5mCuaVVPWnm8zTXj9BXJd2Pyplbc7hc5t8/XMrnZXuBo6ku5psB/FLcIvZCMCgGZyjsfdBfTM5pNCzR4z6HiIUtXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=JHA1GJZL; arc=fail smtp.client-ip=216.71.158.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="JHA1GJZL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1716542159; x=1748078159;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FmOBrHhfl1bfltFQtTWdUGL3HJ+TD19KbF1QLQAJ0NE=;
  b=JHA1GJZLBAMt8H2v8NLog4TVMWFxv8EjDdU/mJPVyz6scZoD5bEgR6rb
   Q2QPb5CkrevcpWdjTFf/9eeFsdJrvwQURoANOm4GRKeMDlqbjWuFxU6GK
   waML5mjqiQmYmh7ZIcnJd1U9zBDCE1IDJLywdyGmeG1qZP5rTOvIoXEb0
   OiTSCjEHBSZr0IcasEnRYVaHTfrDMxVqrTzMfZXreav8nznpG7TcDzpAQ
   egwtHUxqYeccOpgK/lBCQaHL+iRubid8f+iMl0q2s649K0ZqeXX41tKPu
   9fXJ6OTzjCybIfWLrhNZixrdWlYAcjD+EyW0u21xd5VtD6QfVkLnJXzPY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="120166102"
X-IronPort-AV: E=Sophos;i="6.08,185,1712588400"; 
   d="scan'208";a="120166102"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 18:15:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aD4lQq18c5vhx0Jbunt+6SHYNxTUJbtBfLeqlskTBWbKfONDX6TQ5KqA15A+j6pEVoyiGkrR8NhWkkqrrh1dPMwozTNapPNB7ugIdt0zPh1OqnMHmj3SfKjv/DJkpAsdh+lg69cfhkrK6DYYTEj9WLkXU25EPB8qxp/9mGkd5VqDPr/cuxi5XCAUePthe3d6bp1JFhjV5J1ZREmRrbxjOUf6DGRZ2yDy6emcOdOXnbpcDBS8O/4RKpDM6wiEpnd7iiQx7mNgLJlEBVWegv+TjUseLv8OGyXhLGfJkctAeqYkJ+kh14nQCIwru9FMGNK2DPs2JV5VetSq2TuG9MV8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHVNLihRdbkrhBT4K6fPvuMT5g4FozAFZbHRBqjqrXM=;
 b=MsrnI4zmhPmT7vrXz5OjEv0fQYxBj1WjxN0G28rcupFdUPQiCPJG/PLEw/HPveC/korLfXMqNL4K4UE2+B1cZL+mhx1cBoD2lC7BcqGB6iaxtV98CP+mBfeH1o3Nq1xFOLjo3hShbw1KZmgLvUpvXsHzn7Pif3QNEmPEIzn88cT7k5XnJTFI2y2XlP6oPgXqTu9ej6iYq20UZW5wSWIqli/tjt3BQKYayiqBmDvmAcsHstwJZub6qEEdne92c3yfpyBFlRyxPTEW/bdcO6eeOWuQBKdwNT9Iv8sdwRwfyZbS0TOnL6bo5yqZ1jfAWgZjYrsNMUolGb5eCCKWd4df6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYCPR01MB11623.jpnprd01.prod.outlook.com (2603:1096:400:37f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 09:15:44 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 09:15:44 +0000
From: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "jim.harris@samsung.com" <jim.harris@samsung.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] cxl/region: check interleave capability
Thread-Topic: [PATCH v4 2/2] cxl/region: check interleave capability
Thread-Index: AQHalJWFMLLcyIwdlk22sjCGWvAyarF1CckAgAAXcpCAH0D5cIAQ9/AAgADyQUA=
Date: Fri, 24 May 2024 09:15:44 +0000
Message-ID:
 <OSZPR01MB64530E7712375B417C662B9A8DF52@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240422091350.4701-1-yaoxt.fnst@fujitsu.com>
 <20240422091350.4701-3-yaoxt.fnst@fujitsu.com>
 <662707ea3fb4_6910294cf@dwillia2-xfh.jf.intel.com.notmuch>
 <OSZPR01MB64533E9B5F137904A2CBA83E8D112@OSZPR01MB6453.jpnprd01.prod.outlook.com>
 <OSZPR01MB64530A99BD2ED390DF59F01D8DE12@OSZPR01MB6453.jpnprd01.prod.outlook.com>
 <664f8f3e79edd_18c429471@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To:
 <664f8f3e79edd_18c429471@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=f908097f-a29a-4ca9-833d-96bef0b75275;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-05-24T09:14:42Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYCPR01MB11623:EE_
x-ms-office365-filtering-correlation-id: 9f28356d-b560-492c-0a67-08dc7bd2172d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|1800799015|376005|38070700009|1580799018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?RHBmdS9JaWp4NjJ2a3g5di9acEE2V0poaWJHdjdPWHBMVFFXNWtzN2V5?=
 =?iso-2022-jp?B?bkVNUDd2ZEhZcGJFSER6U0RCaHZ6L2NTdHN3cVdZUm0vZnI0cEJLdEhV?=
 =?iso-2022-jp?B?aUpBMEtCeEIvYTdqSTY3R0tnRW9MSVZTalBhS25wUFdiSXQxNWlNTUNR?=
 =?iso-2022-jp?B?ZXZTZ0NlcGwxSUplamg3TE1FU3VSWmNRWkVyQWNaKzBXYkR6VloycUpD?=
 =?iso-2022-jp?B?MnduV3prRTJxMG41TElXRjRVNjdPVi9BM05hSGFtd0NvZFZ1b2tZUXBi?=
 =?iso-2022-jp?B?cFB2MitHOG5Qd08vUnVIRDlhMWliek9jem9wb3Z4djY1NlJRaGJNdkpM?=
 =?iso-2022-jp?B?Sm82cUM2YTV6WTltczlKeEI4ZDVMSkczM1ZHMWFFSzRqOWlmZHJaMG5u?=
 =?iso-2022-jp?B?QmNjUFY2bXhFNzJiY0JycjFOeTkzaU9xSm04amRFNy9HVmJEK3lWNnlj?=
 =?iso-2022-jp?B?YVBaa3g2NEFnSnNDU1RPcWpvU010MHVBdXpSZlU5UTRXZC9CUUpVclhB?=
 =?iso-2022-jp?B?R1JLQ041N0txRW8yR2lzQWNYSUNwVS9VamZMMWt6K0c4am1KaVp4dG1n?=
 =?iso-2022-jp?B?dHFhOXNXaHlyR3RCSzlzR09CQmZnMmZtb01sK2NJL3I4SldCeGJvWldp?=
 =?iso-2022-jp?B?UCs2dHd0ckNzN25zR3BlMDZtaEtyT2xJNXpvM2FMZWFZSmI3V1RPMnZj?=
 =?iso-2022-jp?B?eStSbjQ4dGhVSFVsaUdxTTZrQnVkMHB0WUUyWGxiaExxbG5rTnVseExN?=
 =?iso-2022-jp?B?MmNKY3I3WkQ0SU5Gd2xxa1MrcWhTR1NVTUQ1Y3NtZ00rY05EU1NrWldP?=
 =?iso-2022-jp?B?a3dKNmY1U213UE14NjB0NHJjRlZpUVNCMUR4aXNMQlVmM1h0QW0wM0pm?=
 =?iso-2022-jp?B?K0RUWkx3cFFmbS83cWlrSWJrcG1RQ2xDSFkxeURoN1RoVXJDb2ZmNWRT?=
 =?iso-2022-jp?B?UGpTRW1OWDJZMUVmMTFMbzNlZk5lUXNsdkh5YSsxQnNOTFhhWVBJL1JC?=
 =?iso-2022-jp?B?VUI4NkV4UXN0aHVDcUZOdFpjSk9tbHNpZXRtbEpqcGkwOFk2alAyU08z?=
 =?iso-2022-jp?B?LzlMY1ZGL2k5dDcxVkJzblA1M21uTnFUTkJTbmVQWkxrK1g1VFU3Z1Jo?=
 =?iso-2022-jp?B?akptSVZXeERxM1RadkNnVUZ5K3puSWU4d3FOWTAxcTJMMzRLWnJJMXNa?=
 =?iso-2022-jp?B?U0NzUWs0R2MwWktVRE4yR281clJTWEUvcEdEcjlFK2w2RzJhM1NUeWxr?=
 =?iso-2022-jp?B?U1gyYWtNK1VCOENBVkdxSWdPekxsUzA0N29mMk9JYVJrWHZyNnFkdldK?=
 =?iso-2022-jp?B?TWlmamwxTWM2Z0p1REhIdXdkZjNUTG9OT2J0bGR0WjhmeHl0QS9sQ1RQ?=
 =?iso-2022-jp?B?ZEtKWHFVb1pLemVWNHhJY2NMbVVSblJ1WjhWOWtTbll1b095Ukc4MUs0?=
 =?iso-2022-jp?B?N2NkZjB1VnJGVDZHUWdhYzgycm1DNzNuYXVCUGxYMktnNXVTL2x1Tmp0?=
 =?iso-2022-jp?B?UDVBMkY2aW4yby9tNHJGclNVdVJJeHJwdk9ZUmpvV0pKYTRFS1c4dzNT?=
 =?iso-2022-jp?B?Rkc2Q1haRzE4K0dhSVdCNURpMEV0MFZqNTJ4Wll6V1I4bEJFMHJEclAy?=
 =?iso-2022-jp?B?NjBzSDZQN3dxZEl5bEZYUEFUZHM1RXA4MWMzSFhLTjh3QUR1TStJd0Zs?=
 =?iso-2022-jp?B?cXRKRnRCZ3UzQmN4Zkh5Vk9QMW1ZRVJYamZ4M0U1YlYydkIvUk9lUVRi?=
 =?iso-2022-jp?B?M2l2b3lsSmF1d0xzUDV1MUNaMnZIUnA4TnA0Tm9vKzYyb0dwanhwYVlH?=
 =?iso-2022-jp?B?MCsvMTYvUkUvazRqQjBsQzNhRS9qUDNnYlBFQU14d0FXaWZCRXVTWUFX?=
 =?iso-2022-jp?B?R2xTWmxKYXVFckY5OUU4V3dSa3V2NDZxSHhOck1rc0hacnVweW5icWFp?=
 =?iso-2022-jp?B?aTZqSEQyeml2cm81VnFISExzcVRXZmF5eGg4U3gzZUFnQmZtQXBXVUdz?=
 =?iso-2022-jp?B?MD0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6453.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?ZXlnaU5DekVHTTJ0TFVFQjFFQzROREZrb1RKRUhCYTREUVpCb2x5REt3?=
 =?iso-2022-jp?B?RUYvcVYxUUVIMHVxNitxQVhvajNUN3hYNzNocXRMeko3YUVXSnhRM3Y4?=
 =?iso-2022-jp?B?eGQ5WWhrZzFtcm1qMWdFTTE2QTVUVEt1T0JSWkxQU294SUcwMzRDcjVl?=
 =?iso-2022-jp?B?d3cxWWpOWFN4WHZPbjZmZ3FjOUhBZ3JiWndxUCtZdStXOHNIUVlzM2JS?=
 =?iso-2022-jp?B?NDZZZy9BeTY2QUVGY0NCNGx5bThTTDBtSUdtZEgxSFpPWC9oakNWaUh1?=
 =?iso-2022-jp?B?dTQyMzdPMFphMmRNUDN5TmxEVXhLS3ZaemRsd3pxbDZ3TGcyWnRPbDhV?=
 =?iso-2022-jp?B?MG5iTXAyMDc0a0xVK29BbzFxOVBsa1A2UFk3cUswTEJEdmNRK1A3UlBa?=
 =?iso-2022-jp?B?eXNQT0JFd2V0UDQwRVBHSXNuZ2Y5TVJOaG8vUkNndTcvbzZZdEdPcDRX?=
 =?iso-2022-jp?B?dE9CUldscWFaYlpGRzc5TVZwdEZOSkltWWJ0WjlRVDEzUmlOMmxOcEow?=
 =?iso-2022-jp?B?WWwrV3FrMG01djE2OE5aRmFyNE9NVjdIRWpYQmVBQnpxUTlySjAxTzJp?=
 =?iso-2022-jp?B?Sy9BR2tLUm4rTWJBRVVjbnpsckMxVTdOZmgyY0IrWEZYVElQT29UcDhK?=
 =?iso-2022-jp?B?Z0M5SUU3V2MvZmpiaVFQeXFELzlNWHZpS2VYWEEwcFo3OXkxeHRiUmpm?=
 =?iso-2022-jp?B?YnN5aHN5Tmgzdzd4NmV3VjdpUUc0V3dxdEVJdWVXNHVXNXJOOVJoRHJj?=
 =?iso-2022-jp?B?bU90cTVrc0Q4WEJOSkJGUHVJeHJVVjFFaGgzd28yc0tMQUk3UzFNTFky?=
 =?iso-2022-jp?B?Nk8wNVg2QXVhd3l4NkZnMEFmY00vWCt1UnVIS1Q2SVNvTThkRUpGY3FU?=
 =?iso-2022-jp?B?ZmN0akczZ0xyVWU4MnF5UVNnSTh0NElyQk9oaDFNUFlzSmVGUkJ0UGdo?=
 =?iso-2022-jp?B?aDRucU5nU2JRNThiMk1CQzhlSjJkWUxPVUVaMlFsSWtKMWVkaUppWW1r?=
 =?iso-2022-jp?B?TXR0R05vRThjU3VpOHh2NnNsZ0FQVHZhdHA4T0lPejRZdkp5eGVzVGVL?=
 =?iso-2022-jp?B?Z2plT3ZJc0h5bW1MdmovT1IwNkN1SFFKbVVmK0dGa2V3TVJyQ3VKNW04?=
 =?iso-2022-jp?B?dmZscXpnOTNZd1pnVUpDWGNiTmlrTmswckVLOVF3K0V5b3FRb0l6Z3BO?=
 =?iso-2022-jp?B?RHVvWFNoekZKUUZJUFNDZXlSVlpPWlhYQXFVV0ZMK3V0cm5hS2ViL0lW?=
 =?iso-2022-jp?B?TzdwcG1EbkwwaFQ0WkdzSWhHaVB6TWJwbGFpR0xMaVp4eWR0eTQwMWw3?=
 =?iso-2022-jp?B?bWtpd0dyd2o1RXVhUzE3cGpYVVpDZU1FYWpTYVpFOVdTeWxtZkpwc3R4?=
 =?iso-2022-jp?B?eUI5SkpsQmd1akVkQXg2WFJHK3ZCWXpvOTVRT0RlRHMrNlBzUGw4MW5z?=
 =?iso-2022-jp?B?aWt1SWdUUkhPcUQ2Zmc3d2VCNXVkMTFFSXlKc3V6SEtTSTkvUnNBYmZP?=
 =?iso-2022-jp?B?bkp2elRJRm5BajZIN3UwcHN5T0o0UEZOOUIvY3NPcU5PdzBXNS9nTUpD?=
 =?iso-2022-jp?B?MGptRjVVeERwVnBJYTRnZUlWNHU1ZUcwMWk2NHczcXprR09Vd3JJb0Zl?=
 =?iso-2022-jp?B?ZlhUY1ZkMWsyOEE1YWJ6bG9BY0ZLYnVxOGEyOWJqMnUyL3UzdThFUExn?=
 =?iso-2022-jp?B?dW5xWmFqRnJmWU5zUHovSnNGdEZWaFBvWDZwSGdmWlFDVGUzYjE4UWpx?=
 =?iso-2022-jp?B?b0JDemxFT3dZVm1aMlFmcGNlcktJWEhWZk5wNmVjdWVNUmZjTDFzYjRS?=
 =?iso-2022-jp?B?ZTZIaEdSb3BuV3BsRWRnU2FhN2F4SUREMkFaajN0OWtoL1U2Y2dGcy9K?=
 =?iso-2022-jp?B?Z3MxS0N6ZVV3RlIzbGdieG9jTWsxVUVBczN3RW1PT3NXZFpod2tVaG5L?=
 =?iso-2022-jp?B?TWp0US85cC9ad1JIYjk4Y0w0OHlTSjhieUVSRlpuWERmMDFKYXN4OExH?=
 =?iso-2022-jp?B?emRqTU1qLzNQYWRSQ2d3R1ExRDNJWjlZcmdUdS9DQnpDMmlvZUo1dHFF?=
 =?iso-2022-jp?B?ZFljQm1FNG5pcUZwUkU5aEZHNXQyd0kzazNWM0Z1RFZaOUxuOU5FSWtH?=
 =?iso-2022-jp?B?bjZYOFNKZytXWkh0TlhTNGgySHdLcDZnMWQ0YzlOWjdmRHNlZnJoa1lm?=
 =?iso-2022-jp?B?T1hxOUw5K3Z0ZGFwak1KMldhbU1YZHU0RFFmTW1PakFzWk4vT0VOazBw?=
 =?iso-2022-jp?B?L0hQYy8vVWYwNVJSMVBEV2FwQWpnWEMvRHhoOTdkdnRyN2JPQ2MrcllE?=
 =?iso-2022-jp?B?Y25PTw==?=
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
	5erjxXVFU/RcH0fR1d36Rp3C8GhIVBI9i7UxbATJbb2s7amYkyeM1H9nqn83RbcM2FwV6oPA3aXCKpcYLuhMS1qynRNhPbyNUnAuinShgwYBKWGgTskjilvDh4YAYSLyMhazQ7sys7D5fsxb7SzK2autTxTzSLtvzzswcu8rAij3RXpryigJF5ci810BDCY5W+B3969Ouvdj3LjK+kQg+TFbsHwDb0aMVKfAqfUsU5WupAQ8l69J7jKRkQv4RB9UaVGvlPIphELObR6UC1YKGVGSGpA9ie0LMiB6qrYXlFBhr/0sG4rDUlGz2kbcMgvBXwOURLE3RZqbCwR/eD1SdMCyXtWILQuQ0hIKeolb6wSyWOk1ce/EBUozMS21sh3/VyQrxImtrGT/tEfUjDxwXAmyPGDMhaLVnzgUyx9n7/gMXI5c7u8ckTdx8ac7GN7BdiOtphrO8LOg8n6oU81oikj4R3QxLZPxkUgNJSbJUkDEuLUxDgee58VR2rs0HAIzkiwmejuk7gKKaMx4qfSo19vXktYT3Gn/uwm29clU9lPfF9+7b15zNTrlZxKhv0DNprrFLmJCzIvLnDUB2dJGh0EmqoiYyLN8MJ5dw+Sn3pIx00I30AsX4O2In2lEa2Ct
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f28356d-b560-492c-0a67-08dc7bd2172d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 09:15:44.1649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b4hDC3l92xsZ3dJ7/11cULpwknZBEEz9C5KpZcp4HFZWf6oG7Wzo5/qdGwoxkBPAEd10wjgZs3nCxJNlvmEp1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11623



> -----Original Message-----
> From: Dan Williams <dan.j.williams@intel.com>
> Sent: Friday, May 24, 2024 2:47 AM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>; Da=
n Williams
> <dan.j.williams@intel.com>; dave@stgolabs.net; jonathan.cameron@huawei.co=
m;
> dave.jiang@intel.com; alison.schofield@intel.com; vishal.l.verma@intel.co=
m;
> ira.weiny@intel.com; jim.harris@samsung.com
> Cc: linux-cxl@vger.kernel.org
> Subject: RE: [PATCH v4 2/2] cxl/region: check interleave capability
>=20
> Xingtao Yao (Fujitsu) wrote:
> > ping.
>=20
> Forgive the delay.
>=20
> >
> > > >  static int cxl_port_setup_targets(struct cxl_port *port,
> > > >  				  struct cxl_region *cxlr,
> > > >  				  struct cxl_endpoint_decoder *cxled)
> > > > @@ -1360,6 +1414,14 @@ static int cxl_port_setup_targets(struct cxl=
_port
> > *port,
> > > >  			return -ENXIO;
> > > >  		}
> > > >  	} else {
> > > > +		rc =3D check_interleave_cap(cxld, iw, ig);
> > >
> > > This seems too late to be doing the check. check_interleave_cap() onl=
y
> > > needs to operate on all the 'struct cxl_port' instances between the
> > > endpoint and the root. That check can be done be walking ports at
> > > cxl_region_attach() time, no need to wait until switch decoders are
> > > being allocated.
> >
> > I think we could not get the info of iw and ig for switch decoders
> > while walking ports from endpoint to root, they were set only in
> > cxl_port_setup_targets().
>=20
> So the reason I wanted as much validation as possible to move from
> cxl_region_setup_targets() to cxl_region_attach_position() is to move
> setup failures closer to the device that caused the problem. Otherwise
> cxl_region_setup_targets() will fail only when the last device was added
> and the overall check is performed.
>=20
> > Is the above understanding correct? if so, the interleave capability
> > check cannot be performed at the timing you specified.
>=20
> I think @iw can be validated early because cxl_port_attach_region()
> knows how many downstream targets have been assigned to that port and
> can validate when the number of targets exceeds the decoder capability.
>=20
> For @ig though you are right, it is more difficult given the dependency
> on "parent_ig". So, maybe a compromise is to validate that nr_targets
> does not violate cxlhdm->target_count at cxl_region_attach_position()
> time, but then do the granularity validation in
> cxl_region_setup_targets() as you have it.
thanks for your reply, got it.

