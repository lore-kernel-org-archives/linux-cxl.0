Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BD9256D
	for <linux-cxl@vger.kernel.org>; Sun, 12 May 2024 23:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715557496; cv=fail; b=EZAcZIXfwG10cVPDD2L5WccqZlT+uGGl/rgkxryRxQxc5FjvjF79Wk4BU4rjAH/RAqhvItPX2sXgfiGk/DxpkB1O/aQH/IM1CbbMQo8DnEQMCGNakE/HDcqvlvW17SCip3kwz3wLqOvSlQ5XWFeCc0gombiY7mX2lmaXADImvyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715557496; c=relaxed/simple;
	bh=tSTt881Harmtyox2gzFRYGnFx1DezIV4PLL0HXyRjGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ue27JsxWcPGeHQyfTpIixWZM+zj2tWEXjujltZ/46XoajRVXVka0cG0MaKl1pcOIsarW5pbEuTX0QU990/AE+5A/HYUJDLQ+X78gEKisJx0sXTDdVNr6Nxkjv7Y6p9mtsHyFrQvi7Eup4V34spirQcw+fLmmQwDaQQ8ZSPGVJgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=a+dT4gj+; arc=fail smtp.client-ip=216.71.158.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="a+dT4gj+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1715557494; x=1747093494;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tSTt881Harmtyox2gzFRYGnFx1DezIV4PLL0HXyRjGU=;
  b=a+dT4gj+kzsfgVsdMtuNM21NydqzZ3wagJrIFp87q5t8WvBs3D0koyA3
   1e/aWNUpY7MwnZtZrjwtteYntfpfAgz0ejEIP2ca+fIVJCaJs0gSpEc2n
   oVJ619ubD7Lf2Q4SLD7K460Rn0bALxXELsEVaaoA3057Dhh9Pw20Yc8b2
   kmDd1FlIg+u8is5UWH/AJI06/L+O2XsoXR5HGCIWwWDDhY+qlOLcLMudd
   JZTe/j7UgQhf625xadVehq3fYjHJw37SJTo0ufO0OFDnSlweKznQx/OeF
   Ayowh6Xjbmrg1x/cs2POezxD67QrxjObkgGp+ak0hwdT5vaRKeDolp83H
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="118955124"
X-IronPort-AV: E=Sophos;i="6.08,157,1712588400"; 
   d="scan'208";a="118955124"
Received: from mail-japaneastazlp17010000.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 08:43:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIMYstXYJqjshPvH20QxiNQbGe7uTp6/Hg5ggBdNigiOU9RaXhOd9tEB+SWHgyC/JnrjhfjX0BOmB90S7q++c8tcefiTEL1olzi3Er9yH842E1jmT+SFzQbVxZVcPMHJz4EjD3ADL61mIev6777yZ11sElfFv0mebb+qHNvvKpyk9QFad8m4Gk8h8HI5pCnOB/cEC0Uld2yTnlNOhJiF98GObV31GcQqVrEYwPL/R3zKNgw93wlJkWr/wLUo0x+9WydMFcgR5PhlS0GCp1CdshBTGr3B3+vWNtzKNYV3aijAo/PPHpxgHaLpAGMfc8c5cfDuA3vT7ct9uPxXzRVwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnkKNAmgO27db6ywRqWT2QauyxoJWOWHSlaS6MYUmLg=;
 b=LW2GpFyGUYB/uMs16WvQgIkSMTRBtlgb722VitDlcva7uo5rQ2dixSGA4l2b1gUlYFhzO6WnfdFWbFDs8teG+kEmS18pgmzQTT0Te++ehu/A19BqsRvUYVOtjJfySuCV2TpD6lJBpnXBd8Ux6f9IxubICwBBPcM6mD+ttXjDEoPW+56lQlZoYSJ2QzuewDcG/8uEGuG5p+csebJ30N0ujy49nNCSesSKYK7f08hLxqyxtJVwW116O32TGfzUK0Fy3MQXAQLn+7kw1SXGiSwKhE7m3pp4ebJuu/ItDNUrrA6MOTOt+IJ3pneHtGi3YpmjDiwynxlrhKaUMZ9NnhS5Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYTPR01MB11067.jpnprd01.prod.outlook.com (2603:1096:400:39a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 23:43:35 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d%6]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 23:43:35 +0000
From: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>, Dan Williams
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] cxl/region: check interleave capability
Thread-Topic: [PATCH v4 2/2] cxl/region: check interleave capability
Thread-Index: AQHalJWFMLLcyIwdlk22sjCGWvAyarF1CckAgAAXcpCAH0D5cA==
Date: Sun, 12 May 2024 23:43:35 +0000
Message-ID:
 <OSZPR01MB64530A99BD2ED390DF59F01D8DE12@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240422091350.4701-1-yaoxt.fnst@fujitsu.com>
 <20240422091350.4701-3-yaoxt.fnst@fujitsu.com>
 <662707ea3fb4_6910294cf@dwillia2-xfh.jf.intel.com.notmuch>
 <OSZPR01MB64533E9B5F137904A2CBA83E8D112@OSZPR01MB6453.jpnprd01.prod.outlook.com>
In-Reply-To:
 <OSZPR01MB64533E9B5F137904A2CBA83E8D112@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=ce3ba54a-61b6-49b3-882a-5f2fb24ebbca;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-05-12T23:40:09Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYTPR01MB11067:EE_
x-ms-office365-filtering-correlation-id: a2142c60-21ba-4e9f-561f-08dc72dd5743
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|1800799015|38070700009|921011|1580799018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?TC9JYmJsbkNyMll2TWYyc1J3cGJ2d05ML2xxczJzeDBYWG4raGwweG9E?=
 =?iso-2022-jp?B?UFpoa2dFdk9UWU1XaEtuclAyOTlhOXMzczh0VzI0Tng0c3A5ZUJjWUNG?=
 =?iso-2022-jp?B?Q0thUWIrK1lGbExuY0pHZmowTUNUcmpwUzdvS0NPVDYvMUN5ODRkM3dw?=
 =?iso-2022-jp?B?bnlzYWhjd2pxWmhrcXUvZ2s2VmpLdXZILzlNV1Z4b1c3blJjT0dGKzJK?=
 =?iso-2022-jp?B?cHpkKzlwTks5NEdIQWZZbkZ1ZDRxZjZWOGN2UWZuYTdPeGd5UEtodDd0?=
 =?iso-2022-jp?B?N1lwVmJzYVdSWFFLclFCd1JZZWkvS252Mys3bDRxeDBHM0I2Q3V3ZkNh?=
 =?iso-2022-jp?B?WTgwa0VSSkNqWGo0WVZnODdCQ2htS1FHOExtSUhndlVvd1pLSzhOUkZK?=
 =?iso-2022-jp?B?Ny9Rd3NORzhkUVV6b2RoWDFPelVUTHozNmlJRDQ1eUNudHNoNnI3ME1I?=
 =?iso-2022-jp?B?dlZCN051b3RtejhsVUR4a0lVUTBLYmxGMVdwdVphalBDRjJBWWxwQ2pO?=
 =?iso-2022-jp?B?elR1d1AyREMweXpkUlpTQjNmUFZFaXBlN29pcm5HSTJrRGRsb29pQ091?=
 =?iso-2022-jp?B?TDliZHFraXBpWU1EMWwwbktBVFJ1T1NyOFJCV3V6eHMweHdaa2FzMk0y?=
 =?iso-2022-jp?B?d1ZFa0JWNGI3TDQ0cndtUThIeFg5MXA2eGJ1cDVaMFIvZENKeWVqTFRU?=
 =?iso-2022-jp?B?Zm9YL1N1WVBzS1p3dFZ1NWhMMWo3VER1di96WW5HM3BmNmNsZ0tIL0VS?=
 =?iso-2022-jp?B?ZDd0bW0xU2ZsZkNkRS9XZzNHMkRBWjZFNDMzL3Zib3Zlb1plTnVxQktR?=
 =?iso-2022-jp?B?Ylk3a0lmV0ZzZlJkTm5TTkRqK0Z6U0tvZ3VhUXlkdWM3c1hBa1VSeVZm?=
 =?iso-2022-jp?B?OUtVaWdzZjllUTlrL1cvTGZPTDdzZk56ZERzZnA5Tys4V1JYU1BmakNp?=
 =?iso-2022-jp?B?WjNnWXI1cUVQbzd0TjZFWFFtdFl2bHZGK1BUM1NxV1RLMk56aWE0V2pE?=
 =?iso-2022-jp?B?ODY0OEw5aVorM2hKSlc5dTRLUFVSM3lTR1ZrU3U2YVZUbHMrYmRKZ2Nl?=
 =?iso-2022-jp?B?WnpIT3IxZUp4aDEyRm9rKzI1YWVyejI3NkloUVFiNlovcVE0eGVDV21N?=
 =?iso-2022-jp?B?ZTZ3T25vT21xWFJoR2JKcUtPWHpaaXE2WnZoQ2xueFZ1ZGNqYzFnUTZz?=
 =?iso-2022-jp?B?STFGZHdVbEJXamNPRHNhNFZIaFltaVZLeDRTdFpOVG0rNHkyQ0VTbnFU?=
 =?iso-2022-jp?B?UFlYKzM4WkVveENaTGg4Sk9XQStFSjlCdnMxbE9KRDZITGdJZVk1RFli?=
 =?iso-2022-jp?B?c0ljM09WWGFNckVzaVJWU291cXFmaXVOYnRtWExJZjR4dGY3aXJnS0RN?=
 =?iso-2022-jp?B?eDdnak16YkpvalhXeTRmOUg5NDFYcDdwVXIyZTR4R0FrVytLdW9JSWtY?=
 =?iso-2022-jp?B?UEkzVkdtY0VIelpwbDVOekl0NEpzcWF2dmpGajdGU2FkT0FTQ2lUZnlH?=
 =?iso-2022-jp?B?N0ErMGNKc0lqSk9EVXozWWhkTUVCMGpPZFVhaXdLamM1WEZLRjEwNXlP?=
 =?iso-2022-jp?B?OGp2OEV2UzdxZW5hRVJuK21OSCt5R0w2UEZaemhqcE5yK2hFQkMxT0g4?=
 =?iso-2022-jp?B?UVZ4cSt0b0I3RmxqNkdVNTUrT1NoNzdQV3VUc1NqZ29uem56SVYwUlRi?=
 =?iso-2022-jp?B?Ynl5RlV2aUhwMG5GblBraFBKdyswRzltaHpJL1g4TTFFWHdCaVhvaWVF?=
 =?iso-2022-jp?B?YjJERkVvMmdRZ1VvZ1U0bVlJczVQZzROWERmdWFTUnVkeU1Ob0UrNWxl?=
 =?iso-2022-jp?B?Y3V3LythTStXN1Ziajh5bitPZnh4STJaU2JoQ0pDNy9SWUsvVUVPWUVM?=
 =?iso-2022-jp?B?SkVuTnB3MkRqUWFOYlR0YVNKc1FKUll2YXlvZEhvallGNVpCY1NSS014?=
 =?iso-2022-jp?B?cm9LUXg0REhqL2hvNGR4MTltYkZmTlU1MDVYR1VLeHp4ZjE3bG4xclQv?=
 =?iso-2022-jp?B?U3ZKRW9EaXNwT2lsYzlablo3bkFIaQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6453.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009)(921011)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?cWNndVluNzUyWHVaN2RuWjhMVWFTNm9nMXUxRU5Dd0VXb2NVWHZieWxr?=
 =?iso-2022-jp?B?a3ZzK1FOL2ZJTERraGVkKzkreUJVemtPbEhmemJEaHJEclhQZXorMm9B?=
 =?iso-2022-jp?B?Mm9qKzRtazgxdmZ0b2duYzQ4UUVuRHN3cUVKRUErVjNLVVRhbi94S3dt?=
 =?iso-2022-jp?B?ZWhhdWNNSko1cFdCQUFRZlRIYUFqdldoWjgvTUFkTW43UmdLSGRXY2dw?=
 =?iso-2022-jp?B?U25QVGptTERtbVlONkRlMlllVUVodU5CTFNnejRRR045RG10cVhNQ1dZ?=
 =?iso-2022-jp?B?N2lodnJPbXV3NjIyQUpHZGdaMGVZM0U5M2x2eWVselZTTk56MFhhRjZ2?=
 =?iso-2022-jp?B?cFhRMmRDejhPb0Z2VHcyQVI1Z3ZITzkxSEI4Znl6ZytRV0FXdEpiaGZL?=
 =?iso-2022-jp?B?T1N5Wk9tWkMrYWhqblRZSnJURXVVcC9pK2kyMFRYckFvMldmQnljLzdO?=
 =?iso-2022-jp?B?c1NDd1czT0dST3RDcktOVVVkNjdkcEFGbkFLOVFXdGlmT3A4V0owT2sy?=
 =?iso-2022-jp?B?T0pVOVR6Z1lHOWdSQ0NRYytUOFlXb0hkUy9XMm9JaXBGekpHdGhrRXp2?=
 =?iso-2022-jp?B?QytqYlMzSTVJalRtZHVqMHNPZjAvaG01OUF5VStwRXlzcEpOdGRMb0Z4?=
 =?iso-2022-jp?B?cldPdWlYY1N3QkIrcHFmbTRnQ29VRlExN2xBdVJEdkdvV2VOcG1pdnFV?=
 =?iso-2022-jp?B?WG1VLzZMRXhROTRRYVprdHhmMWxvayt5V0JNdU1YNEJzUk5TbHRsa3Fh?=
 =?iso-2022-jp?B?WHZ1d0NONDJvR1IyOGwyakJrTU0zNlBhbkJIanZCbHBoa1hZUEFPTmY5?=
 =?iso-2022-jp?B?RzEvQnF4dnpYdm5vSjI4ZEF0VVpwTDR3N0ZSWHBpN2ZDNVZtbFNnZGhw?=
 =?iso-2022-jp?B?c3NhVFlVZ3V2ZXNkTGdGbzBpaHJzWWdhRElqMVhyQ0E4bERaTmZteHU3?=
 =?iso-2022-jp?B?djNMdGt1aWYzblNhOEpjTUpQeXJUc3I3OFNIUzBRY0hLNjBqbXovenEy?=
 =?iso-2022-jp?B?c1BHT2ZtTGJzQWpicHBLTlR0bnJHUS9jZk05bFlsZUxhc2c5VktNcVhR?=
 =?iso-2022-jp?B?ZzhrYW1LVnpXY3dSazdiTW1pK1pzV04zSzdzRStlR3NheEM2a2F2VVJw?=
 =?iso-2022-jp?B?dWZ6dWZVbmRJb1poalRiTWNPWVROU2puZ2E4YUppaFJkV2tLZXVLeDRl?=
 =?iso-2022-jp?B?RTBGL0I2V1ZQcUxkQ1ovamJCeElLdkYxcnQzcytydHp6TTE3N0pncVUz?=
 =?iso-2022-jp?B?L29NUTZZZFJNYWRPcDFTYzNNZmxmOGJ1cHlpLy9WTllteTROOGd0RHJG?=
 =?iso-2022-jp?B?T1JjTjlyRVoyZnNoUHpiZDVuT1FDREZTalhWTUpxQ3B6MmtUcjJORnUy?=
 =?iso-2022-jp?B?bHZmNERQd2RUeUY0a2JmRm9BR2txamtrZFJ6U2szL2ltK0IzSUx0Tit3?=
 =?iso-2022-jp?B?ZTN1bUdLb3d1RnVYOUthK0IrNkJRcEZyVXBrNE9EK01YcW9abk0vUDlB?=
 =?iso-2022-jp?B?dW5SMnh4L1UzLzJGVEJjTDQwOS9EYU0yYytKQ2FHRm5lMGtMSXRHNUNR?=
 =?iso-2022-jp?B?MG1LVmI2QTc0cTgyMHhicU1mejZ6bStZVnROcnlPOWVKZW9GR20xeWNJ?=
 =?iso-2022-jp?B?bXFMSms4NjFYWHVmYWVlSkd3M3JKVk9zcWxBRk5vVkFtU2VBNTY2RUo1?=
 =?iso-2022-jp?B?Z08vUy9qMW5mWUxBZ1htQlM0QUJjNi9TYmNFNlRqckI4bWZ4a2Y5T3dX?=
 =?iso-2022-jp?B?NVg2RUVrMUZiUC8vdWxLTmwwTnNXL3dSKzg4K1lFT1MzbkwxZ01jeW1X?=
 =?iso-2022-jp?B?RitpYjZuanlOMUk5R3hralBQc0lzajBsdVE2VlFjYWtkS3BCMW9STEJE?=
 =?iso-2022-jp?B?Nkx6djd3aVcyTk43RDNLQ3pwUWhTMzBxTEhaaXVickszMkw5aHRUNDhM?=
 =?iso-2022-jp?B?K0ZYU0QwblR6YlFMZVd0cHkzbEFybytFWUJJSlFpR3NuZkdHYzRQU3ho?=
 =?iso-2022-jp?B?MzdYTzBGVzRVbGZaS05qV29JSlFZRCtNdjJZUFZxZFM4L0pKYXZBZ2dR?=
 =?iso-2022-jp?B?M2ZZYWVGZUxyTHFCaDAwQzJvcnQrak9mdEZaZlFoUWRpS0NPUUFDZzZV?=
 =?iso-2022-jp?B?LysrL2dOeUZGWE9QSnVKRjEwRnZHMjN5VExjSmNsN1VBbjU1ejYxUDNy?=
 =?iso-2022-jp?B?VVI2K0JZUTFiVk9XVVkrRGRKenZzSUYwbXAvTWptYk9ZL0QzZmJNM3du?=
 =?iso-2022-jp?B?QVJvYUVvSzY2Ly8wdUdEZFk0S292Sm02eUlxSTJ0Wnh0M2VJTVRzc2V2?=
 =?iso-2022-jp?B?cGNDWg==?=
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
	WRyz1xm0GmCsBdEfe+KZxCyQs59v3Wpf4URHEui+t8LBbZvbzOP5NRZ/PPHtwiBqHDfu+h8UoStJMIXQTnzr/oIBHB1IIMhrUjx/TxkeI9jM3k+wfYlFpZnYbUqfcimfYISwdsBBdm0f2VtFUN+9jCpeKElinaS5TZken6dFp7JYP1VPLRoHmicerSvp4QG+YriI5moA4358YUu4C0TvBpq9kjZ80Sbp9IlzDDybasoSQUkXny9fxhhpd04DNpD9sT9XAlpEPU5vQoIjRKo4eEhRNmdNGsUtbCoSdO9t0cp7UtihY6f8zklB6PioFwC3SHJP1g3VRfBGG6MWtDBXfuWHTCIxfKait2sCJlPpTjQi28W8MCPW4IzJPZ7d6hQoFIKufapmnu+a47Roxau38tJpF0hzyHx13br6TCdGVW93D3naR6lciYJ+EASStoGvjs4swudN1KnKVow/w85doaFWBvnE0Ir+ZzROKwTH0+7Txh8xmMsNzyGDPzKDNvKXGl8JilyN/LtuiH39dHAWhm/kwliOrfzOvYehWU6MLi16K1ElU70Egr95BAdydy/g1wVXBNfyuXNythvS7ieytfwuyTVSAMoZOOCfY0trLrOT/7i0xxRJc08fs5pNfar/
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2142c60-21ba-4e9f-561f-08dc72dd5743
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2024 23:43:35.6641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQxMVqq8U1HQ9jMukimxzJcz3DPWKSrS73AUWVp0SfuQhzSlkjS1RSqhdpjIR54JYl0QmMoZEiqMACsCSTiYbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB11067

ping.

> >  static int cxl_port_setup_targets(struct cxl_port *port,
> >  				  struct cxl_region *cxlr,
> >  				  struct cxl_endpoint_decoder *cxled)
> > @@ -1360,6 +1414,14 @@ static int cxl_port_setup_targets(struct cxl_por=
t
*port,
> >  			return -ENXIO;
> >  		}
> >  	} else {
> > +		rc =3D check_interleave_cap(cxld, iw, ig);
>
> This seems too late to be doing the check. check_interleave_cap() only
> needs to operate on all the 'struct cxl_port' instances between the
> endpoint and the root. That check can be done be walking ports at
> cxl_region_attach() time, no need to wait until switch decoders are
> being allocated.

I think we could not get the info of iw and ig for switch decoders while wa=
lking ports
from endpoint to root, they were set only in cxl_port_setup_targets().

Is the above understanding correct? if so, the interleave capability check =
cannot be
performed at the timing you specified.
