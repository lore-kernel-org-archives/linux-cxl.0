Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1561FCA
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jul 2024 06:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160206; cv=fail; b=migfcnUMDEmLqF/LR7mGceHJntROWsxBsOHRJCNuysrycpop906CZa0+zDByKl0A8kJ1qYots75T+d5zK6pDT5Wj62/kslx2LUcEd2m9nKvqQHYednsRJps5NfEpbjnS9Uz0am33bV0bkTy9DPppCX2vUAx9NzWGzPJtuLI9w28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160206; c=relaxed/simple;
	bh=9OjEGnm6tDT4UvUtQfp3WiK4LZ/5P0sh+eXWoFun1Ik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G509uJKQoHO3G2Zh2GwqRI+F3NnjKKnUwPeHJLYxkUUB2kl1xXh8q4SjwsOLXe1XZZgOs3rropTAmrUFUGDTz9aTAXHyWMRnUpiZ/whEm/+K7Mq/NkjEQv/BFEgzDs04rN6OKxeqlmybuHt4UOEjXHjamFXVFemyQo0LYT3Kf+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=CevMraGW; arc=fail smtp.client-ip=68.232.159.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="CevMraGW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1720160202; x=1751696202;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9OjEGnm6tDT4UvUtQfp3WiK4LZ/5P0sh+eXWoFun1Ik=;
  b=CevMraGWqTq90CjDY2rLXVoc2NTgNt5lzg2YcEgeRppIsWeXlVHN3Wyb
   CacsBm54M+YXQfFS3/y2nfHElpPUdJaaGm3z8VJmNi04IqmuIKW0uiGWJ
   7vUPeNDa4Rgn3KEBC/GT6HROPSbQaMiwjlbtnrVJAnIU0a2bXdjGwR5Xh
   RUS7fDOE58g7SARPMnJ0g955mVipVUNNq37LtRrjk9hTthvnJaFGb0Bzi
   s3Md3NOumwUsZG//HoMgGsRiz+Rj2IlD8ddJ1fNMKM423QnBotK8/2r0S
   0lBbrDrLXemFXte07NWvSB66LL++6ubb30BX/P46M4pzVAGyyotBpz8EH
   Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="124462038"
X-IronPort-AV: E=Sophos;i="6.09,184,1716217200"; 
   d="scan'208";a="124462038"
Received: from mail-japaneastazlp17010002.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.2])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 15:15:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHbYINWdmZwH8e2ZaI3XFwGQoE7wp5vZBJVJxm829KpOEGmRG/taV9dqngDfds28QsD5ypi3YXW5NHkfsgKyAcS/2wLuNGMdyEOGAj2MFUPryzAwzurV9W6YnOi2dOX+jhk4YFyUvFYgnIypEs/nfLPsht3AWIinM7Nd7FzhO5FB4vYp0XsAu94/thC7SNmi+ijfA9rqDrx6+lSkZWjJ0n2oMCF21SS7+j3r1oQohmN0wHBis/L9vmK/JVjPIhLpJlQr95J+Z0+Ga27dcLFUgfeYJ1a2abeVWks5kARB4nmgEV7rQAhHTioyWVdqbSZGBSMAZI2W2QB/h5fkqceMqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwVSC/vG+Ax/AB9nEsAjB/TlIGIj/GWff7ZS7YUJvhE=;
 b=V/5VBTY5gah3uZ3joKBfODmF9N2Tw8DCAfa6tuVz9t36K+2ebZdNgKQZZo3RmsIM0qJPTROAgevM2ikflxKp1TVMuAHe0TmHoyNT6faFPsdcM/1X8VDj2QukE+8S1KuwC7FUqoXPSZX3Fh7GGQ2IUZAxmnueuYl9onUAgp1vbxe/DrxCkdyXamVPiVRmFSmyeRagJN+Kji03pzAXVzH13LpX/1oPHAVbV4irUNkLCJqVmhdZ0BdnXHKc/q60OyY+KP7FWqQSI4jl4sSRNWqZwzb2SE+nCLE/nko8do4V9xlAEz/TStiebMUB+2MS1fWO3Rw26XTCK0QcGM37HQoO2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB6464.jpnprd01.prod.outlook.com (2603:1096:400:7e::7)
 by OS3PR01MB6373.jpnprd01.prod.outlook.com (2603:1096:604:e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Fri, 5 Jul
 2024 06:15:24 +0000
Received: from TYCPR01MB6464.jpnprd01.prod.outlook.com
 ([fe80::882:d445:280b:8484]) by TYCPR01MB6464.jpnprd01.prod.outlook.com
 ([fe80::882:d445:280b:8484%2]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 06:15:24 +0000
From: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
To: "alison.schofield@intel.com" <alison.schofield@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave
 Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH 2/2] cxl/test: Replace ENXIO with EBUSY for inject poison
 limit reached
Thread-Topic: [PATCH 2/2] cxl/test: Replace ENXIO with EBUSY for inject poison
 limit reached
Thread-Index: AQHazaqE7EUXPx9nmU6X/JufJCuMK7Hno3Eg
Date: Fri, 5 Jul 2024 06:15:24 +0000
Message-ID:
 <TYCPR01MB6464AD7628D9B17C13BDE1598DDF2@TYCPR01MB6464.jpnprd01.prod.outlook.com>
References: <cover.1720052137.git.alison.schofield@intel.com>
 <e13e59c43a456f56e275d039cd0f67c6117230c8.1720052137.git.alison.schofield@intel.com>
In-Reply-To:
 <e13e59c43a456f56e275d039cd0f67c6117230c8.1720052137.git.alison.schofield@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=32f6ce0c-ec38-4289-b5d3-d0ca0a53f0e3;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-07-05T05:51:38Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB6464:EE_|OS3PR01MB6373:EE_
x-ms-office365-filtering-correlation-id: 1f52047f-9ff8-4e80-b926-08dc9cb9dbbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?emQzVVdDRVRjTDg5dTJaS244NEFGM1BpNk1nb2R6dC9wU0dpUnoyaklK?=
 =?iso-2022-jp?B?RjFaVVBxQjE5UWhyRUtKdXZ3TTJuWk95T1RFZHY5SCsyMnVGZXpsV3ZM?=
 =?iso-2022-jp?B?OGNtZ3pTYSt3T2hSL002VVJGaXZXaUFxeU1HaUJxQ1BSZm1FeUZwRDZV?=
 =?iso-2022-jp?B?dUYrcWQyQWExMmlMTVBtZER1WFc3TGxNdzF1M3k4NGVoZHJkcDI5SHcz?=
 =?iso-2022-jp?B?cnJod1M3T1VkWHNjU1B4VG1UV3Q4MEF5T3RDYXVtRXdWTWkvaWMzTDJD?=
 =?iso-2022-jp?B?K2cyRGhYVkpwUndQSVRudUhNek9tbHZDeHR4ZFVIdjZzWTVwVDlLS2x5?=
 =?iso-2022-jp?B?SThDT25BWFNTamxmb2ZMZ3I5bkk2Tm94ZlZoeEduUXJEUEx0bE9UTnFV?=
 =?iso-2022-jp?B?MTZmNk1jMFc2NGJyYStQbGx5TjJNQVVXUGtqblE4aU5RdXJZRXZjMmRy?=
 =?iso-2022-jp?B?Rkx2ME1kOGNQdVNtb0FueHRpbFVHRnYwNjBxaWNmNGRWZ01YQmV0V0hi?=
 =?iso-2022-jp?B?M2tZZVgxVmlHQmlkL1hLZ0pmYWZEV2RtNXR1cWVBOEF5UW9HbEZxbUlv?=
 =?iso-2022-jp?B?Z2ViUkg5dVFHaGEvc3JOaXc5Y09aZldodkRGOGU3bk4yVzJPdG93dDFM?=
 =?iso-2022-jp?B?QmxYQTQ0azU2OHNFU3NZNC9XaHA3UFB6MVc0Nld3VFN2dXg0dklrMGIw?=
 =?iso-2022-jp?B?VnhvWU9xQ0tPbSthclRxSlVGSzVmaUZqQUxPdEJlMEgrSVV6L0pjakdS?=
 =?iso-2022-jp?B?b094V2JIdkRVRlBUWXEreXdLMC9SZ3htT3EvdnQxTnFldjQ5RDZSNStF?=
 =?iso-2022-jp?B?Q3F6SnQyUDhPUTBjVVFVcFI2WkJQaVNyK21GOWpqR0s4dXhrZWtqUkFr?=
 =?iso-2022-jp?B?M0YwL3M4dWpLTThkOGcvS3RveDkyV2w3OU9aRGEzakNxaGJ5UEtLc282?=
 =?iso-2022-jp?B?cVVjUHkvN2tRZGxoMmRsalJXY3NyWjRrcm9BWnRoVnVLQnM4eXYxdC9Y?=
 =?iso-2022-jp?B?dmYzRlVPRE1DYnkxNmtVWkhrbXQ4QzhhaHRUT0Y2MzB5aXFuWDhkR0k4?=
 =?iso-2022-jp?B?NDFYS2ZIMnNuNDFMY3ZpOFpLYkZ6WlJJeDhaUng3V3dVeDZwY0FKcXA5?=
 =?iso-2022-jp?B?RE1FQ2N0ZE10eG9DbExielJOUnlwRVpVZ1U3eSt1U1pXN2FTY0ZVUUVI?=
 =?iso-2022-jp?B?TGRaVlhhaGlaVm55VHkycmVrQlMreWh3NXZCUHFOQWlYR2htVWJ0Nk1Z?=
 =?iso-2022-jp?B?YUg5ZVE0ZEhPSi9QRUZ2anJZaDVEUnMzb1g2c0xKeExQM2tzZE9JMEYx?=
 =?iso-2022-jp?B?aS9uVm95blNPVk9mMkJlei9UT25ZYk1Cc25DNEh4Y3puSURweXVaR3Yz?=
 =?iso-2022-jp?B?Rno2QVMxL1NMNHpwQTIxcko2WVV0M0RIL09adjBrVllVVkg4TlpYNXAy?=
 =?iso-2022-jp?B?M2kvd0Z1ektsQ044bUluTHl4aFVyeXZpZ3V6dlUvUFI5Sm5zRWZHalRz?=
 =?iso-2022-jp?B?WmllNDExSmY3L1dwckRVR05NVlgwbXVpNzBzNDgyZXRCMzFaM3hzTjlC?=
 =?iso-2022-jp?B?TkRyR1lzVi8wMW1tajZHOGlFUFR3eThlZjk1TWM0eW9VQ1l4WFJqWlB0?=
 =?iso-2022-jp?B?SkI1Wlk4bm81UUVBMFVKajY0WHFjcHliVkRrSGRpalBjN3pyTkJSdENW?=
 =?iso-2022-jp?B?OVd6ZUJheEFmU09kUkw4RHR3TExJOWlZYVFDUHhVU2paVCszTFBoUFhj?=
 =?iso-2022-jp?B?VXl3UjlnYW9KNnQ1Y01Uak9ZV2MwejVKNVJseEZQb3IrbzdrY25DSU5F?=
 =?iso-2022-jp?B?TS9JWXk3QzZFU1hKMFdLNkR1eFpsR3N4ZW8yQUxJU0tzY1QyYk15WnF3?=
 =?iso-2022-jp?B?TTJYQXVQK1pGbXgzaHd3QWRGNTNrMG9nTVlTM1JrVU5tL2hpWXZsVWRM?=
 =?iso-2022-jp?B?WGZobmd4YTlmSHM1Y0ZrZG9LZ0duc0ltRVlCdWRBeXdvcFU0UGdhbWpF?=
 =?iso-2022-jp?B?VjNvK3JIQVJmVGsxMWlvTk9VdHhNc25JQ2RiRlhoZC8zM3pib2d5QkU1?=
 =?iso-2022-jp?B?Wk5BZ24zNXNaSE9NakFBYktPRUdpZlU9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6464.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?b0RPb3ZBSkVEeGVGRzBTR1ZCeG5IV2VqdWtnY3llNDltSzJwODIxRzll?=
 =?iso-2022-jp?B?RzdHR0xaSGFoeDlaN05HQXhocmp0K09kRmRRNGxpaXZLbHlHOUQ2NWhU?=
 =?iso-2022-jp?B?QmhqekpWL28xUko2OEZ1R0pldlB3elBkVy95YXcyVUE4Nlh5MWpUNnRw?=
 =?iso-2022-jp?B?WVZpZ1pCNFJ5cnIwNm9CTUNtMCszb2RSaFR2bkkyRzgzVWVzYlBsaisx?=
 =?iso-2022-jp?B?Wk0zYkpSbm9EeFVOVEtZeHpyRVdhYWNqM0JLZ3hLU3NQLzFKTFloMUNm?=
 =?iso-2022-jp?B?d1lLamxvZ09tK2JvNWJBV2JLbDMzSTE4ZTZkMzNONzQwZDRkZHRsOHRx?=
 =?iso-2022-jp?B?V3crZmJ3T0RTMnRkM1pWdU5JKzVWeUdienA0QmYwNjRhb1F5Sjc4VUkv?=
 =?iso-2022-jp?B?R215cEQ4dFJKMHRGRGNuSGJPWHBhNUV1UmJ1bWE0ek0xaXRmNU41bWdq?=
 =?iso-2022-jp?B?R2FyNmlzTjg5ZTYwYzAwbzUyM2xJVk1oNEQ3MXVCWWlWVUdXeTVDSURC?=
 =?iso-2022-jp?B?WVplVzNZRllMTVIwVXdVZWJlQWZmNytoS0wveC9XZ1hHQzBONmJRaWR4?=
 =?iso-2022-jp?B?Y0FQcEtyTU1jQ1QzRm1BUjcveGdiSkJxODhnRkRWbE82bGh5NmwvcXRE?=
 =?iso-2022-jp?B?VUVjbm0wZ2I5TUJhTklGcmVTZEIxVjFYTTNYRmVsVDYvSENUSm93MUtI?=
 =?iso-2022-jp?B?bW9PZzR0SE9ITkYxN25lWXE0dzk0SnBZdmk3Mi8rejJ5YmRXQXBWWFFZ?=
 =?iso-2022-jp?B?WnQyM2VSQVhUZFN0S25LWklXQm9TV015eUlaWWNpWklNaXg1SzNMNHQy?=
 =?iso-2022-jp?B?eTFicSsvRUpmZCtMalRZZjdHRkNPNzE5RktrVGtPUEZtSHFXS1hVV1hL?=
 =?iso-2022-jp?B?eWYyZjl0YmdqSzhmbTZBUzgwZTJhYllnZFhOLzdienE4WDAvYUFuZFVC?=
 =?iso-2022-jp?B?eFZBMVpFL2d6ZmoySzZTT3lpV0w1R0dTYTRIK3J0dXNBdW5KODBDWlJU?=
 =?iso-2022-jp?B?UXhtWjVUOGpWOXVuT1lGVitRY2hoR2NVeVJJQnB5bVBHSU90Z1FPSEZQ?=
 =?iso-2022-jp?B?Tk1UdkRob0FuRzE3eFJwNWN4ekJDb1dVVE1wenhGUUhwNWtKQjJPc0dx?=
 =?iso-2022-jp?B?VHN3ckRhRjRlbnE0K0dwK2lMZXNWdkUrcE9aWWltYjBGMkY1QlowcjFM?=
 =?iso-2022-jp?B?cGI0VmR0VUdCNFdibDVPY3Qwd1I1cnIwTis2ZDRTbTJFcTU3QmVYNXhZ?=
 =?iso-2022-jp?B?OWF3OVowMlJVL20yc2Fsd3dWVkNLWFFPSXJ1dGUrVkdnNGE1QWdYMmIy?=
 =?iso-2022-jp?B?Q1ZINlhtK1VkRXhKbXpUbW1TNHdpOERZdmRsem1hUjJ1SDFPMjRVK0Vl?=
 =?iso-2022-jp?B?WElFRm5udWgrV2J6QjV6V29jMm9xc3VmUHpDSFRDRU04WlIzSmJ2TTF2?=
 =?iso-2022-jp?B?eVBmU1luNzVtYy9SSUJXNk9nWHJVa0V3ZFg5cU11djNGYk9za2hKZ1ky?=
 =?iso-2022-jp?B?YlZxc3MxaVI0QU4rSnBydUg4WEVidllMUTdadzBhTkRrVTBjVCtyQlh4?=
 =?iso-2022-jp?B?S2RkckRXNk1Gc2pDdVEzNXVmWnZGVnZINm02bURPeGpRN1ZOeGNjaXVN?=
 =?iso-2022-jp?B?OEpkTUZRNFZRMTF4Mis0SlM0RThtTW1sL0JYMEpNSHdlell2dm5Cd01l?=
 =?iso-2022-jp?B?QkFaaDJpM3YyK3NGWDJ4V3RZbXdOT011Z2NRNVlRenhZZWtMRDhjUkFV?=
 =?iso-2022-jp?B?OU42anZFZFlseGh4cFFtOTllQ0FiQ1dvQU0rWjNzbFprdUgzNzFtOVYr?=
 =?iso-2022-jp?B?YXZpZTcxUFpGODNIRk1ZeU0xemo4TWR5bUZEblhIQXM5ODNNeHdWbWVl?=
 =?iso-2022-jp?B?ZFU3WlJqUUJrekpCSmFYUmZWdlFjRHdPeFFGWnpXU2tWTnl4L2JPWWlF?=
 =?iso-2022-jp?B?eDNPUFNVQTJJYi9qSG5wZTlxdHVmTHJ6YWpJaGRIVmpFTWxtMEtGVmcy?=
 =?iso-2022-jp?B?RFBMRUlOcnBZOXBXNTdhWFpUMzAvY1Z3M0o5SEFxakxHdlI2MmVHaGk0?=
 =?iso-2022-jp?B?VFRIcVdkbkJEL3JNSzkzL1FUVVhMQ2dMQlR4c2tML2lza3Y3Nmk3NURW?=
 =?iso-2022-jp?B?blNrVHhqOFhmL1ZZUDdON2hqOHNaYkFZUzEvemZSam1SeDVEdmdHR2kw?=
 =?iso-2022-jp?B?cGNuUllWeXZsamp0VDhiWU5FdTZSbUduNGM1NjczN3doVjJ5bU0rbmtF?=
 =?iso-2022-jp?B?WWZpNStlcVcvbzFUaWRJdUhIL1ltZnlZOG41WEFINUxVay9Tb2NwT0NL?=
 =?iso-2022-jp?B?dnd1dw==?=
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
	aw5M3f9tKxwsF0pJfZV0LfKh/Zmi0OlvtPFLDyjfvOPB9+IwJ/ogUf5+3f/SVt/Xmfomloto78zqA6EcE9Yortpfe5S7xEN9HM6Z7/zfDpSbcB1AZKfgjP/xHURCE4rbdsO0FZ799rDHxcC/rz6Mig2qyPvEvpRukuzWjspeXk3MLuvYYpUaSaR5fUte1ua4yyWEp+3DqxdQNuls3EobVW03oO2FsyDwXPUAMySJTZALW/SipkTJHdMEGxYzW+NbUw5oIZJIJg+D++AexM3FevFX088NyqfNGlOOAajL2d6kV1CdkHz6OQ0+7MvnK3aBPqSyQFoSqOITibn+K4NMJfgXs4H5SFtY4llXA5EqbMYTrI3jK/w8klYTwMBKzOO68aAGktxsgypbZf3QQT0uvhBdFo0kwd0g0ZhusAseH0xAAfiVse2MEDRfg1zd/eM7K1snnUPP6nCp44BgYtJbt66+bGJuP8NHkLhj584KSrWjxEUBk+Gml6U1xX5hgTu1dkpJHBeKF4Cg6p+vFBB+8tGlhC4oMU6G8/482TpV2SmRw426bt/X8HQKVulI/OJEOA2P38akHfum+N2WGUWPkjLGq5iqoypUuZjZ7MyXRwhDJR1qDA2/VHG+g8ydcgsy
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6464.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f52047f-9ff8-4e80-b926-08dc9cb9dbbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 06:15:24.9385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SB+TtEsuGw8QIBT+NytkeA8lEQ1nCZ9bK0SR+y6c3rfNEkaK//V5ryzLl/h8gna9lmuCtJdIII4FLpaAJCMKuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6373

> -----Original Message-----
> From: alison.schofield@intel.com <alison.schofield@intel.com>
> Sent: Thursday, July 4, 2024 8:38 AM
> To: Davidlohr Bueso <dave@stgolabs.net>; Jonathan Cameron
> <Jonathan.Cameron@huawei.com>; Dave Jiang <dave.jiang@intel.com>; Alison
> Schofield <alison.schofield@intel.com>; Vishal Verma
> <vishal.l.verma@intel.com>; Ira Weiny <ira.weiny@intel.com>; Dan Williams
> <dan.j.williams@intel.com>
> Cc: linux-cxl@vger.kernel.org
> Subject: [PATCH 2/2] cxl/test: Replace ENXIO with EBUSY for inject poison=
 limit
> reached
>=20
> From: Alison Schofield <alison.schofield@intel.com>
>=20
> The CXL driver was recently updated to return EBUSY rather than
> ENXIO when the device reports that an injection request exceeds
> the device's limit. That change to EBUSY allows debug users to
> differentiate between limit reached and inject failures for any
> other reason.
>=20
> Do the same here in cxl-test.
>=20
> Reminder: the cxl-test per device injection limit is a configurable
> attribute: /sys/bus/platform/drivers/cxl_mock_mem/poison_inject_max
>=20
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  tools/testing/cxl/test/mem.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index eaf091a3d331..5e0c84d4d9f8 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1131,27 +1131,28 @@ static bool mock_poison_dev_max_injected(struct
> cxl_dev_state *cxlds)
>  	return (count >=3D poison_inject_dev_max);
>  }
>=20
> -static bool mock_poison_add(struct cxl_dev_state *cxlds, u64 dpa)
> +static int mock_poison_add(struct cxl_dev_state *cxlds, u64 dpa)
>  {
> +	/* Return EBUSY to match the CXL driver handling */
>  	if (mock_poison_dev_max_injected(cxlds)) {
>  		dev_dbg(cxlds->dev,
>  			"Device poison injection limit has been reached: %d\n",
>  			MOCK_INJECT_DEV_MAX);
There is a tiny issue here, we'd better replace MOCK_INJECT_DEV_MAX with=20
poison_inject_dev_max, as this value can be configured through=20
/sys/bus/platform/drivers/cxl_mock_mem/poison_inject_max

like:
# echo 128 > /sys/bus/platform/drivers/cxl_mock_mem/poison_inject_max

after injecting 129 poisons, the =1B$B!H=1B(BDevice or resource busy=1B$B!I=
=1B(B occurred, but the debug message
still output:
[ 7664.280587] cxl_mock_mem cxl_mem.0: Device poison injection limit has be=
en reached: 8
[ 7664.280591] cxl_mock_mem cxl_mem.0: opcode: 0x4301 sz_in: 8 sz_out: 0 rc=
: -16


Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>

> -		return false;
> +		return -EBUSY;
>  	}
>=20
>  	for (int i =3D 0; i < MOCK_INJECT_TEST_MAX; i++) {
>  		if (!mock_poison_list[i].cxlds) {
>  			mock_poison_list[i].cxlds =3D cxlds;
>  			mock_poison_list[i].dpa =3D dpa;
> -			return true;
> +			return 0;
>  		}
>  	}
>  	dev_dbg(cxlds->dev,
>  		"Mock test poison injection limit has been reached: %d\n",
>  		MOCK_INJECT_TEST_MAX);
>=20
> -	return false;
> +	return -ENXIO;
>  }
>=20
>  static bool mock_poison_found(struct cxl_dev_state *cxlds, u64 dpa)
> @@ -1175,10 +1176,8 @@ static int mock_inject_poison(struct cxl_dev_state
> *cxlds,
>  		dev_dbg(cxlds->dev, "DPA: 0x%llx already poisoned\n", dpa);
>  		return 0;
>  	}
> -	if (!mock_poison_add(cxlds, dpa))
> -		return -ENXIO;
>=20
> -	return 0;
> +	return mock_poison_add(cxlds, dpa);
>  }
>=20
>  static bool mock_poison_del(struct cxl_dev_state *cxlds, u64 dpa)
> --
> 2.37.3
>=20

