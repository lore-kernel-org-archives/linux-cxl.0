Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA6A45000
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jul 2024 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720162822; cv=fail; b=MfJ7BYteYQwi+1sjcs3JPOQxNPQOfF2GICfpU0uqXQU0XpimnTL9JUfyqgOmQ3S53NMLAR9A7V+6IJRKrYvJPjMiFdJnqcvEZG7s97E6ghONnyCSbv3Q84Bq9stJhuGaPpnTFNDhiSNbpuGPR+U7Y4yT8MiB7WoqSA8VAuCuimQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720162822; c=relaxed/simple;
	bh=tDymq9MNiLNMKd+VaILhCOVIOocUi0NOs9HHsaGducg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kCtjjlSHBbi32md3p3lTm1ym0aCV27WjDTWrtls8d66dsxVt2HnXIN1GtaBJtdN5/L7mNmv5k+ypSdKiF5uV6lrsNylOPCRs5H6lxAYPwq6R/r8TNYLDzPs14Jv+EgGYOXKhjMjFIhu8wb6M7qcpkA/biWx5cUQVPd2s681RQVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=CKwAlLw4; arc=fail smtp.client-ip=216.71.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="CKwAlLw4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1720162819; x=1751698819;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tDymq9MNiLNMKd+VaILhCOVIOocUi0NOs9HHsaGducg=;
  b=CKwAlLw48KUO9Q7ZcRvmPldEIxSY1R89SMoBWEjTGHUmaAIqXFzpB2XQ
   Q0dVctLFMGn2Fou5C1uaqTgyLgfGp2ajK0Ezfd61yx6UaxoA5x0K/QsRj
   CYk2o+8b7PooMrII32ttSlyWOtVDyRTWhayPfk5Yq0bsxln82pwO2SoyQ
   WD0wF8tHY0DGTRFtHs9IxDwHtfMPLV9BUsYDJ0bQVb4Ep+K64N2Jz5158
   K1N+C5wjpGyia06T5RszBpGZmNLsCvJY6qRBEtz94/AiM+Qfh5vCcVc+X
   daH8N8ce3BNr0dvhUf1WSqy3bt3ClJtk9OdSKF7X+PFxcZCs64cUj2rOx
   Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="124509452"
X-IronPort-AV: E=Sophos;i="6.09,184,1716217200"; 
   d="scan'208";a="124509452"
Received: from mail-japaneastazlp17011028.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 15:59:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y37z3jHLqsBUZRgC0quzVySPoO4CLtmF6EtZnb4jca7jiEMx/k7KAL0WN3kYeE7/rAsV7TDaTVioHrlyhXRX3l4YOeiE9kqg+jE47iWgJWyeQxaqJj0dbUj4cohqksAbs4Svn3ZQ7OuZbGklGx6VNqPCjTZmoO1tsxtrVJQhUlI/8i0DtlsAKz5RyxISfN3o9S/uv59OKSS/3U72x2/Dk9yr6zMxicc/WUV/Gi9VPC8qTumVglF7b4g3VQLKj9OlKrV1UlJB/ltThT/yyA9jjGON5bGm/w0/ojAMp1OcUPhXuigB0ZcGJgyf6lbdYmgz5MAuqZgF8fDjT26GFpFmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghYrlSujB46NE/BavGd8YBc1YcvAca62XcX9rs0OQpw=;
 b=LXtBj7cJpvhM6xtIuzpPFJu4n1NBVFjyYgG/tsx+/PaklFfRdmk/SErVhtB1B5wTEwI5sb7CGYqEfix4jCiIIYqsZk+Hr+dmojG5o3e9taP4SLXd7GtJkvKrF/hGEnitKePrv1RHW/21P06hZihflRezUcOX0I3rlCrgJbcrnKwlWfji+sX74Wp7dojtKGxac0u3I37DdI6Go7H7mi/dRP7LmJljDtb756nZ0KPLjEA17I33Dl1Aa87lcpUBQi55n3iBmwua4WFpYu5WkZWbpkBsIjDYNNnOkPAEeBeT8+Z7KHtaq+gbjmQUCh6qlmVG47VhxqVVNphhJhX86Zg19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB6464.jpnprd01.prod.outlook.com (2603:1096:400:7e::7)
 by TY3PR01MB11642.jpnprd01.prod.outlook.com (2603:1096:400:370::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 06:59:01 +0000
Received: from TYCPR01MB6464.jpnprd01.prod.outlook.com
 ([fe80::882:d445:280b:8484]) by TYCPR01MB6464.jpnprd01.prod.outlook.com
 ([fe80::882:d445:280b:8484%2]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 06:59:01 +0000
From: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
To: "alison.schofield@intel.com" <alison.schofield@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave
 Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH 1/2] cxl/memdev: Replace ENXIO with EBUSY for inject
 poison limit reached
Thread-Topic: [PATCH 1/2] cxl/memdev: Replace ENXIO with EBUSY for inject
 poison limit reached
Thread-Index: AQHazaqBWV7rOHIAREK4GdenyLlg6bHntjLQ
Date: Fri, 5 Jul 2024 06:59:01 +0000
Message-ID:
 <TYCPR01MB6464F0A36A6112696CA0D5F08DDF2@TYCPR01MB6464.jpnprd01.prod.outlook.com>
References: <cover.1720052137.git.alison.schofield@intel.com>
 <3d37cb23115a99dbf38913360c65e360038ad6a1.1720052137.git.alison.schofield@intel.com>
In-Reply-To:
 <3d37cb23115a99dbf38913360c65e360038ad6a1.1720052137.git.alison.schofield@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=24fecede-4012-4f60-ae34-4629a7785597;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-07-05T06:58:44Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB6464:EE_|TY3PR01MB11642:EE_
x-ms-office365-filtering-correlation-id: 771d8f12-3d53-48ba-80ae-08dc9cbff346
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?eGd3VWRwYmdrZTVPUGE5R2tqekorSU83Z0cwR1dyRXMzcnVVekZRZWlZ?=
 =?iso-2022-jp?B?UCtidEkxNFA2WkhEZU4ybGJQN3JvekdzMmk1bmFZSmxxN2pwUTZ4WDFi?=
 =?iso-2022-jp?B?K05memxEYmtUc1JQd3R0Rk9uUjVJZ1hJUk54all4OGZnN1RoVnEvaDhM?=
 =?iso-2022-jp?B?M2hWdDZQNTJHSGsrUk9pS3ZoalBXa1ZMaTJSSFlaYmEvcU1hU2lRT29I?=
 =?iso-2022-jp?B?ZGg4OEtSRWZSYjJ1NXhIT0NLOXlYYVZsZ0FGWDcybmZDd2xqeTd5Nlc1?=
 =?iso-2022-jp?B?VjBYeVVEd0F0V3RPMC9RRFM4S25ybEVSVW5BTk1rZ0IyN3JDVHFjVFVo?=
 =?iso-2022-jp?B?ZlNCZUN6dXpKZFN1djFOZmczUDltZUxrWVRGRW5takMyd015TG83dTdq?=
 =?iso-2022-jp?B?SnAxNEJ5NUd1WjluN3NlL0xxaHFpZWVHTk1QVGVlcW1CMkdFUGc2TzlN?=
 =?iso-2022-jp?B?M2VoZFNtbWExNEJ0UjdZR2w2dEFDREJPekpEbVFSZUhaVnVsU1cxZitX?=
 =?iso-2022-jp?B?ckJMWWZGRTY3RlVEVEpXS2QrYTFRbFV4Z1BzeXM1MXZNL2FEZlhuYU14?=
 =?iso-2022-jp?B?V1NXa0RmS1ZoOUFZeVZoVm9xNytYR3BkeXpqSHlEakoxU01rQXE2S3dT?=
 =?iso-2022-jp?B?bUpxdlNKUVk3VTdqcWFiUUljekRnUEFDKzNjb2FTRmxkK2hKaTd3TUZS?=
 =?iso-2022-jp?B?YktFZlpzZi8vU3NyTnBJNm1ObEVWT2R2L2Y0UkFwSVNlenRIYnI1ZDNS?=
 =?iso-2022-jp?B?Q3FzWk0wb283bkZndlRuTldYWXlzanVKa3ZjZjRPTFp4MG51Wjd2SnVF?=
 =?iso-2022-jp?B?MXBKRi9RS08yY3IveGNJSlBaenVQL3lMNUNrblpUK01WMk5POUttS0x0?=
 =?iso-2022-jp?B?c3ZtbTRMeVVVbUNWVHRlb3Z3V0o2ZWQ1dTRLRDlubjZwazB5K2ZtNWx3?=
 =?iso-2022-jp?B?RkNHRXdCc1pNeHh5Q0RKZTFpdTJXTnZMdTRsVjhtZmVxMXJPZERCZ1Rq?=
 =?iso-2022-jp?B?QmVlT2tHbW9aSVdzVnE1dG9UVTV4VmlOK2thdDE5YzloRlNFKy8rUU1s?=
 =?iso-2022-jp?B?ODd4ZUZsbEpvcEU0VVJrd3ovZENMN2k0a3g5dTd6NldMZUgyaFlkdS94?=
 =?iso-2022-jp?B?VmJQMkE1eGJwYWgwSmZveUZUcDRBMlg0ZDMzY1lUWHppTDdBRjJwdzVW?=
 =?iso-2022-jp?B?RTBjQ0xDeE5oVkhkMi9NbmI3SStVRWdEZmQ0OTF0dGlYSFdkSHZnN1B0?=
 =?iso-2022-jp?B?emI4UjM1dDJjSlNtRlJaK2IxTW1nblFuMFJjVlg3eHRJNnViZERsN3R1?=
 =?iso-2022-jp?B?SURhS1JCNTZuaXFWWFlTNy9FUThEeG1DZW1sVkdldWtqeG8yWmNHMzZJ?=
 =?iso-2022-jp?B?bWZqQkY3MTYzUFI0czJqMWZrbFVvbXB2ZC9YVDhDNlpHVkNCRCtYY0hL?=
 =?iso-2022-jp?B?amwvYVdhM1FaTEdrTjhVa015WkZZN1ZzcnZ1dldQQTdFSHk3REp0NXJw?=
 =?iso-2022-jp?B?Sk9KYS9pa0tkRE9CQ3IwRWhtNit2NlJON3NzV01xVTVjNTBmTHJJdkxK?=
 =?iso-2022-jp?B?NTUyOGFDUEtiemRIUWVZOEJkYWkyUm10RjB1R3ovbTEyUkhHUG10Z1Yz?=
 =?iso-2022-jp?B?dDB2TFBHUENZTlNDU2JVQjhzYVVHLzNGcEF1S2JkZWM0SmpHeERyeUNq?=
 =?iso-2022-jp?B?VVdRQXB5VUtraklHN3VncHJMSVdONlNJMUoyWWhUNlRPUGd2VlYzZFc3?=
 =?iso-2022-jp?B?YVQ3clN0UnNTaGdwWFkyOUhVaWY1c1VZVXh2MHZQalM0eXBkWmdYc3Ni?=
 =?iso-2022-jp?B?R0NxbU5XUkkza0daNWlHZ1h0ZWR0YWl5WlRSM09YNVkxL2JRd0s1YnZn?=
 =?iso-2022-jp?B?NnBWaGVXMG4rR0owMFEyWFB6MktPWG5EWXNYZ0o4aHAxandjWXpkK2l0?=
 =?iso-2022-jp?B?RW9zTVhGMkwwcTF4S3VQM2tsZENpTTBDbkp4ckYva1NWNTV4cmdkallz?=
 =?iso-2022-jp?B?bm9xcGE1M1NEaFlCbUg0Z0Q0M2pUNy9RSDBQY2M4YnpBY2s2RzJIZTc3?=
 =?iso-2022-jp?B?UFR1VWMvVUptSE1qMk5uYVp1UTJWKzg9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6464.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?dUEvMEEyK3Z0WmxPSi9JWnhnbENOTmFUalI4OUt6RnViU2xvalVMUXJm?=
 =?iso-2022-jp?B?bjFvVVdmTFkvdXZDWTRkdk5SY3BtMzB5WTlsZko2Qy80OU5KeWdQd0U1?=
 =?iso-2022-jp?B?MDkxSjhxcDVES3ZLT1lLY3F0ZTk5RG1jV21Pd2x0dnFQNTRkR3dRdXRz?=
 =?iso-2022-jp?B?MjhmU0ZlOW5vWTd2eFhWUnBBQXg5a3o0SVFZRVBpc21sVmpUZ0J0SHI4?=
 =?iso-2022-jp?B?WEJqUmRQNWpkcmNKU1RqVkZwMmlVK1doZ0JzaU40d3M1L2lGdW5VM21h?=
 =?iso-2022-jp?B?YUdyUHRQUWh4QlMyWlhmdlByMjZYaERyTXBOY1RmUEVScC9QMEtpKzRO?=
 =?iso-2022-jp?B?STdla1BWOGZtWitEYTAyZGNNVS9DN2w1S0pDaFQ0WWNLRUJ0SGNQMXIz?=
 =?iso-2022-jp?B?ZVYwbWtZQTRQb0VGMnJ5OER2U1JlTFZLbmZLcW4raDFZT2xDVHlVakpP?=
 =?iso-2022-jp?B?ZTNkbHlOVlkzUklCanpDYWxtY1hBK1NqTU5wcUh2ZWZjMi9ZMVhVK2Rj?=
 =?iso-2022-jp?B?dG94VXB6RnpDVWZhRFNVaG13TitzdWtZbTEvaVI2NlJTOWk5V016eUJ4?=
 =?iso-2022-jp?B?ZE4zNzJYY09Wcmk1UVQ5SW9sbkRnVzVxSFM3eDZSbjF5WGdWbTZjZmk1?=
 =?iso-2022-jp?B?ZmNPQko1QlRxSEZGSytsRGhSWmRMNVNMVTJNcTlOa0NqMGx0SG90b3BM?=
 =?iso-2022-jp?B?OU4xdUJQRFhhVHVUZHZQaFhwOEIyZW9icmJYYjU1MzFsbGF3aUlaUGQw?=
 =?iso-2022-jp?B?OGt2bE9mdkFGb3lMaisvaGUxVktkQ3JtaGI2Z0FmY2RWdE80MzVvcEJK?=
 =?iso-2022-jp?B?WUJWbDR6ZVJkSU5LZjJON1BQU3J0cWhQUkdNdFk4c244QVg5ZFBaRHM4?=
 =?iso-2022-jp?B?WHNhOW8zNWdZZlVtLzZMTHgwZ1RyL1dqNDJlUEFVdFdFV0hQNzEwRXZ1?=
 =?iso-2022-jp?B?NC9XZkN4UXV5ZURxeE0zR2s2TkE3QUIwdTR1R3pmdmhOOHhSTnJialhY?=
 =?iso-2022-jp?B?eTZTQ0J4TTJHQWtXTWwyalM2VmI5NTQxQW5vT215MEV4bVc5eHZEeDgy?=
 =?iso-2022-jp?B?TFVSZ1ZXNkxicWQ0cjJJMkFsZGNlaGNNb2NPN1JFQlVvVi9CTk1QeHpZ?=
 =?iso-2022-jp?B?Z0ZtSThHQm1pUUMyTTVDVXF1U1pFVkoyVFplUStqTElKQm5Ec2YzcXl0?=
 =?iso-2022-jp?B?YVJoNEFKQ1RXeVY0M3dyQVpsNExvWHJtc1NQejNRYXEySVdqNWt4dGRS?=
 =?iso-2022-jp?B?bDRkMW9FY3ZVblFMZ2JVeWtzTFZGandjczQ2N0dHRzVtUGQ2MnFWMGJY?=
 =?iso-2022-jp?B?TmwvbXlJSkk4akx5UUJwSGhUaDgyTFF4cjZ4N2FxWGNrc1RsTjVlNlYz?=
 =?iso-2022-jp?B?bEZOY3RYdTRnc2ZXdlF1QnZWS01ITWZ5cnBQd1B4VjY5NjdsK3hwODdj?=
 =?iso-2022-jp?B?TmcwNjRNeis0K3pXRjBieTlkMFU4dkxjMUZPN0lzNzhDRDlCMXdDRHJK?=
 =?iso-2022-jp?B?TWtkbkthRCs3NFpxRE9IVkdGMExndFZSVDN2MWpUTSsrdDhRYkVxYkdx?=
 =?iso-2022-jp?B?SFBHbGtmZXg3OXUzajIzdVdRM2pZVHlkRUlOOWgrQW9JRXRHQTdjL0tJ?=
 =?iso-2022-jp?B?TVBqNWZ4MTJZYUNYUW9Ra0t5eGJJeDhHQ0c0Z3NKZmhQVHRaWDNuWDAr?=
 =?iso-2022-jp?B?Uko0VUY4R0VwNTFxdXVma1lvcUVTRWRvZXVHRTFqbDZoL0l6cVRNRnJU?=
 =?iso-2022-jp?B?aXRaT0dha2FkSXJpb1R6dnhUamE5YUtib1hxbzhBQVJxWWFEUHFzcm9D?=
 =?iso-2022-jp?B?cGIzK2c2ZTBNWnRnWTZzdWY1TFdydkZQL2txTXgvb1JHaUVZK1VtNUlT?=
 =?iso-2022-jp?B?QlljN2Rmc3ZDbTZHU1Eyd2dtRkZKM0lVM2Uvb1FmMUlGdDk2SGJoeGZD?=
 =?iso-2022-jp?B?R0J3OVlzejZhMlJXMzVSNFdzQzJVQmlXSldtaEVDVmsrM3VHME5wNU9M?=
 =?iso-2022-jp?B?cHNXN01MZG5qSUdIc3VrN2xnRjlaU2UrR2lnQ3VaOUMwZnhvK0JJZkdr?=
 =?iso-2022-jp?B?ak9kT3NRamVXQk1mRzd6dFExekxQYThyNWpVSnVFUUVKdXd0NmsxZHZp?=
 =?iso-2022-jp?B?aXFjVGJKKzJXWlR3d3NBS1pWYlgyME9tbkF5NE1kQyt1aHkySDRCMzhU?=
 =?iso-2022-jp?B?a2ZEanp1MTRxTkx1ZVFEUHVQcWo4N2ZtQTVUK3BJODRJV1RGeDZ5TTR5?=
 =?iso-2022-jp?B?VzVQTjZpZzRhZnByWlZHS0Uza1FqaXd6SmphNzdMc2Q4dldNNnQrYzFF?=
 =?iso-2022-jp?B?UXhHcQ==?=
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
	8wzEJOooQRmf/d6QItTlozW2lSHqTiIw5Lv7DtYRpRzari4tcJRAZ17SE4HvEXH59QUXmFRbIPqNGnCOlJqxNWNsrt6iRI82Qx0ky/peW9gYlGy22LA/pOFveGJSkaVE7dbFo+/LicamoS2NSSWKIXBxIzYyVUHd2XS1Fd1dhHdV01hTdc0c1D6rwS8Gvs6znKgdaI8GjsQJAtdct7acFK3fZuMth+gmDOqVlHZrCCFCED1KE1fyhaqolCrIbHEG5eP7Ed9T0RkGyOhLu2W9nAIBjEbkmo+cZ5QX51+SaTpWmzW/GcyRNORRsBDvC5odyAHnN6e/jCYmNMZ8mUu1ZJVNZteAj3b0baj76WrJIFW+J/yxlncaqADhw1zFTwJdNC+otIZ1NtJnxQxPB4Rr4/712Di8CN9Z6oSPtfHKvyydviLYrxNaOT4fc1i4s95LpuyagQ4Si5T1JpI4B0oqzIxzWy5zcmHrPMWlqKmn6BNv9wq7PvMwltCDY/L1Ce2e3VOXb89yN2t04Vux1J81PoNZLjv/u9CsPOYYUi+nzqFpEyozZdM9sD7QpDk2Aju5DOnZpdtkHVyTqKJMECi2sZkdSRhrKRWE5K0QnEt3vkZ7xYWpSZLEX9uY840CwlCI
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6464.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771d8f12-3d53-48ba-80ae-08dc9cbff346
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 06:59:01.3524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PSqh3RY6o+ZX14yxDYJZ5YR72Egyts+o5OVgsblnhMgY6TuEuxw1nZ+2TYIofosI3nXVGSLG1pxy0O+sNAo0og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11642

Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>

> -----Original Message-----
> From: alison.schofield@intel.com <alison.schofield@intel.com>
> Sent: Thursday, July 4, 2024 8:38 AM
> To: Davidlohr Bueso <dave@stgolabs.net>; Jonathan Cameron
> <Jonathan.Cameron@huawei.com>; Dave Jiang <dave.jiang@intel.com>; Alison
> Schofield <alison.schofield@intel.com>; Vishal Verma
> <vishal.l.verma@intel.com>; Ira Weiny <ira.weiny@intel.com>; Dan Williams
> <dan.j.williams@intel.com>
> Cc: linux-cxl@vger.kernel.org
> Subject: [PATCH 1/2] cxl/memdev: Replace ENXIO with EBUSY for inject pois=
on
> limit reached
>=20
> From: Alison Schofield <alison.schofield@intel.com>
>=20
> The CXL driver provides a debugfs interface offering users the
> ability to inject and clear poison to a memdev. Once a user has
> injected up to the devices limit further injection requests fail
> with ENXIO until a clear poison is issued.
>=20
> Users may not have device specs in hand or may want to intentionally
> hit the limit and then clear. Replace the usual ENXIO return status
> with EBUSY so users can recognize this failure.
>=20
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  Documentation/ABI/testing/debugfs-cxl | 7 ++++---
>  drivers/cxl/cxlmem.h                  | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/debugfs-cxl
> b/Documentation/ABI/testing/debugfs-cxl
> index c61f9b813973..12488c14be64 100644
> --- a/Documentation/ABI/testing/debugfs-cxl
> +++ b/Documentation/ABI/testing/debugfs-cxl
> @@ -14,9 +14,10 @@ Description:
>  		event to its internal Informational Event log, updates the
>  		Event Status register, and if configured, interrupts the host.
>  		It is not an error to inject poison into an address that
> -		already has poison present and no error is returned. The
> -		inject_poison attribute is only visible for devices supporting
> -		the capability.
> +		already has poison present and no error is returned. If the
> +		device returns 'Inject Poison Limit Reached' an -EBUSY error
> +		is returned to the user. The inject_poison attribute is only
> +		visible for devices supporting the capability.
>=20
>=20
>  What:		/sys/kernel/debug/memX/clear_poison
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 19aba81cdf13..942063c09459 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -161,7 +161,7 @@ struct cxl_mbox_cmd {
>  	C(FWRESET, -ENXIO, "FW failed to activate, needs cold reset"),
> 	\
>  	C(HANDLE, -ENXIO, "one or more Event Record Handles were invalid"),
> \
>  	C(PADDR, -EFAULT, "physical address specified is invalid"),
> 	\
> -	C(POISONLMT, -ENXIO, "poison injection limit has been reached"),
> \
> +	C(POISONLMT, -EBUSY, "poison injection limit has been reached"),
> \
>  	C(MEDIAFAILURE, -ENXIO, "permanent issue with the media"),
> 	\
>  	C(ABORT, -ENXIO, "background cmd was aborted by device"),
> \
>  	C(SECURITY, -ENXIO, "not valid in the current security state"),        =
 \
> --
> 2.37.3
>=20

