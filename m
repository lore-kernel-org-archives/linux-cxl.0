Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2216AAD
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jul 2024 03:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720407605; cv=fail; b=O+FFeCnEOWT2cmUO1sBaTWG5OZgX5/Ml+stjeh7SGs4tLKZxIg8athAe8R+EgCZLFNoHlT798C9gMTAP5oCl600ynSSCShoNrtZm874D7GOBowWq3csLOBpBiJX/xSV9jdl8erErf3BItYmIitpVpJR/oJ9wjydhBwJeHXzHnbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720407605; c=relaxed/simple;
	bh=q5OxK8KI+e3xQQINkDewEwEwGCDULLe+wQZ73Q0r1nQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VmxoSaevIBYRG3TlsahUsOkFYSBGw0r3GXfP1MbNWcsTrRHjxdNA+t3kCr0N2YxR96PqexHrAFfivtgRMWb8t+d/G+ZeQ59cDJHX7/qkDvlAbqSeZ2BPXmhvUioO4rjXZ7uFNUpubjh8ESBWr4EpVLnLhHGMdcO+oGYu9HdCR6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ixN7DDEP; arc=fail smtp.client-ip=68.232.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ixN7DDEP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1720407603; x=1751943603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q5OxK8KI+e3xQQINkDewEwEwGCDULLe+wQZ73Q0r1nQ=;
  b=ixN7DDEPdu+ou5ZaR9O2GMnsbTB38NdZwg5lD7eG9HbgVeid76pcWLfa
   zH1QUMCacIaLeci9zyjL1r+8/vZzrzbn7FHG2XiapBfmbanZdiKErMujC
   F5G4q14R7kycbQSUrYv3EDXgMKkZach06FOzMVpfIEWRjdPSF4Hf425GO
   HSoci1fibfehvqZtlScP/XG6t/fznpM0WKoZEGOcMPr+/rDjtrrQEYJSd
   W74unZnyd7CazzkklWjERczEQmvTA5ZW2j959Kv5pRu6Cur4og4bScJHh
   R7G+EojyBOnQSlhBFdKljFblN8gGstigQtJm1Qz74Ygl1pkC3l3TBdrdd
   Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="124448019"
X-IronPort-AV: E=Sophos;i="6.09,191,1716217200"; 
   d="scan'208";a="124448019"
Received: from mail-japaneastazlp17011030.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.30])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 11:59:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPtnzJTi7ugxNfqvNGLL8LlrLHksdcXs32VcWtOWyoEfGJJrna8w6n5CKWaeNqIJdV+x53t+v5e3E+2PwJQjtbJL/LlSRtQhkigSBAf5v+oQS+0mT4sRx2J3r6KMlo75IlS6eHPDP+bz+Hn9ftUsSzuFkGRYnN6+mrTqIYaaOz2CpoR/6v1ifpSZpxgnRQ95aj1TSylVyWXTcq/yATdswIQ+Dbk6rGYfJXV0VBvoXjbwreQqYQ3ee3aqjJSksrE73MuBqWMDW3XsAy6GGzoZ+qw5qYieSEQv9EAyxg+w3C8kLcSfNV2tUk9IICVo1Ux+sr/+w7feEf/qDQpgCXnbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbbyFcMV2EQ1cz6wkZ9U25hdjxf9hmRER/ucn7bsWhE=;
 b=bBpkcvq+PFfkqlJFvPDe/IsRrLAE7cTYqL0z3hs4RlTxbklETS0eb5CO6M+17NXp2Mypf0KftCocvgEZzU0I5JSHEN2lxSeJ7IcXCQ5Hsm3j/yCGXLUCCUJX+9Ty8kD7eFjIeZQSG9odAI8wQ2ti2ri8eYV1+fx3711LtFiSXjopOUq8C5Qf4QGITm0awb9AFDVKgJvzQ52+zbs8UXGZ4Pop8lCtHMI5B/nQvPKe7GhJd7X15pwamAfkdw/bSaqooNdBtCX0jEuSeHU++HcqPLaS9EfJ7d0r1dlRhZsGBeKRcTaFV7aD1lmbAtCyepqI8Wg2j/0266jXQFGeJbwehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 02:59:56 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 02:59:56 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v13 0/2] Export cxl1.1 device link status register value
 to pci device sysfs.
Thread-Topic: [PATCH v13 0/2] Export cxl1.1 device link status register value
 to pci device sysfs.
Thread-Index: AQHawG+aGLCoZksU+UeLAeVxavfGfbHsQubA
Date: Mon, 8 Jul 2024 02:59:56 +0000
Message-ID:
 <OSAPR01MB7182B96D1C5314D09E418284BADA2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240617043702.62028-1-kobayashi.da-06@fujitsu.com>
In-Reply-To: <20240617043702.62028-1-kobayashi.da-06@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=3109b8e0-3ba5-46aa-9888-d054d09b295c;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-07-08T02:52:41Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|OS0PR01MB5442:EE_
x-ms-office365-filtering-correlation-id: 9a8c3cb7-e909-49a8-3ed2-08dc9efa0c48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?WURGUlZLNWJNeE5nOU9zcy9Ia1REMUQvMm4wa2ZTa09vcjdHWldwbGNO?=
 =?iso-2022-jp?B?UEdSNnoyRGNDaU0wejdJS01iOVFtM3pxMzBYaEF5VU81SXU2eUNhOXRT?=
 =?iso-2022-jp?B?Y2Y4Q3hDZVBFbzEyTVZUaUpiQlFNY1p5U2pVUGIwdktvYmZnS3VGTXZs?=
 =?iso-2022-jp?B?Y3Uxd3VSZldmeTQxMDJadFZTdHhoQnNnb3R5UXdzNitlUXYvV1hqaVQr?=
 =?iso-2022-jp?B?VEkyaHFlL2g0eDdTZ2trcWNSMFY2ZUZZaWljYnFFVFM0N3FsU0w4akg3?=
 =?iso-2022-jp?B?M1dOUEx4UFBsYTRZd3lYTllZQTZuNnpuclNwZUo4SWZ1MUtaMTkrZDU0?=
 =?iso-2022-jp?B?UW9ndGxVRWxLYTZpdGllQlovcUpZRndmWUdXRUszK2RTYnBSTzVpdTBj?=
 =?iso-2022-jp?B?MlVUdGx6a0V3MWIzb3dYZlFzZnBacXA1RWNyQ0lKN3lPOFJQZkszZ0V3?=
 =?iso-2022-jp?B?aExxc2RibVN6blRSYmJkMkY2cmxRb0JyVjBRaEVPZmh5RkNhR0dZYWxL?=
 =?iso-2022-jp?B?Y1pXTG9Yc0t3QWhKOUp3a3FHUVNybkVjNHl2dzVTcTVaQW40S2NsR1FT?=
 =?iso-2022-jp?B?SU5ieGFYNmY3MHYxSll1SFlWaUEzMTJVM0tTblY2TTcrbWV6b01BNUQv?=
 =?iso-2022-jp?B?VWx1UWFwdHBaSGtrQmZOeHcydXliSHlUMVVQczRUdWZjbWRoaWJadndX?=
 =?iso-2022-jp?B?eVo3d0RXWUpLVXpId0RhRTdVWDV5UFNYTTlEczMwMUpNUmZtRTlDVGJZ?=
 =?iso-2022-jp?B?TnJDaG5RSS9ZRURiRk42RzJTOU1wTCt1UlBkTEpKYXlOa0R0R3lZTlNn?=
 =?iso-2022-jp?B?RG91N3MrRWRnKzgxT0ZlVk5USEtlMC9EYk1YTURmeVFBL0JjTkFTcDdK?=
 =?iso-2022-jp?B?UkNEK01ZYWxFSXVGNi9KZnJBOUlUekVBbVNiL3gxWUhQSTIvb3NGRDRm?=
 =?iso-2022-jp?B?V0gvWHdRbEo2d2h3SFpseGxDczRLV21sTjQzOGNVWlV0VFo5dk9XTi91?=
 =?iso-2022-jp?B?OWsxQklxdm9JUUNCd0xJdVArY3daU3owNVQ5RkNFVDlMMndkRmp1RnEr?=
 =?iso-2022-jp?B?dno1cnd1REIzbTZ5VEo0SGdJVXFkK1B6djhXbGEzZ2JoTStxdURFdWJI?=
 =?iso-2022-jp?B?T294RCs5WEt6L2VTbENKVDZXVkhWSnpxNzR2ek8xd09wQThGUkRIekw3?=
 =?iso-2022-jp?B?MHdOaDJiV2twb1hla3RWc3h5eXFzSnpYL1FZWUhORlBjU1RrUFN1RXBE?=
 =?iso-2022-jp?B?a2swZDc1S3dKLzhST2E0OXA1S1pzaTZRRzFqQStYdVJwN0w2UkJxcDRI?=
 =?iso-2022-jp?B?QjhRQ1hhdk02aVZRUW5zVWNURVdvYVZmaXJMbXBXQnRhWktHWnZyMGpx?=
 =?iso-2022-jp?B?U3BPbGxJeDE0VnpTNGZlL1NwUXlmeGExbUZWdHBXUFJ2WUllMWFCMVZM?=
 =?iso-2022-jp?B?STNobzVleTNDSitOOGNEazR1M0prS3hxdTl6d1lFMVhMVGEvcVlSVFlR?=
 =?iso-2022-jp?B?SHY1bEJFa0tNWFlDenJiV0t0ZkRNaVFtbGJ5OUk5MnVHR3J3R3A2cmJT?=
 =?iso-2022-jp?B?YmpCMFhYdjNYM0wrbmxUdWQxNFNaN08wdEFVZ0JTL2FPMi9CcDZqMHp5?=
 =?iso-2022-jp?B?WWdZZkxSaUJvSnVwSzM3ZzhNT2NKaDU2bU1xOER1bEFOWTRRclJ0UWxH?=
 =?iso-2022-jp?B?L21nZmlxTzJ4YWpmRVJWM3k0ditrc0pramhWWE1jTzlCM1h1bTE0bWdV?=
 =?iso-2022-jp?B?dnBTS1hjeUN6QWFad0loUG8wdXFldThMdmg5VlRXbmllQnpGaWZYckZY?=
 =?iso-2022-jp?B?aDJxbFVuT05uYkJPWnorMzljcWx5R2Q3MW9HdjQzRmJiMWJEVUp6Rk5E?=
 =?iso-2022-jp?B?bTdoQkxmRWVFMlFpYS9ReW5NWTZEeTkvSHBLbFNIUlpkdDUyR21CQnlK?=
 =?iso-2022-jp?B?WmJ5SjNXeVpablRtd09FRjljclN5ZTBsbklUMW1uSXdOai8wb2hUVHVp?=
 =?iso-2022-jp?B?ZTNyNXQvT3dTTjkwMFAwNFpXZWpEUzZwWjR4dmtPQ2g4WHJHNlBXNktR?=
 =?iso-2022-jp?B?T25hNC93UC9MWTZRMTZocktML0NhWk09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?U0h0UnAvTzNHQkJYd3JoaG5xM3RJQXV2bzFaRkRnYm1uajRBaE51a2Yv?=
 =?iso-2022-jp?B?ZkxFL3UyVmM0L0RHNWlMd3h4R3FwakRyWnF0S2hROGIzeVF6RTBoTjEx?=
 =?iso-2022-jp?B?TkNzNWEzZE5QMlFYUmVUVU5PK0J6Yms3L3VlTWlKbDZpRE40cHRsY2F2?=
 =?iso-2022-jp?B?WFJhdk1tZGlZZFpEdk5vR1QxZUp0NHo2Z2V2cWlDZ1phcWFMZTBiL3FF?=
 =?iso-2022-jp?B?czAzZjlKMzBMVDFYYUw0elByWjVLNm16TFRvekk4aHA4aXhIZXUwYlZY?=
 =?iso-2022-jp?B?ejFvWDJTZUgzaFNqR2ErU2RPT3RHU3o1VVlXeXBsbHNxVkFuU0swQ3hV?=
 =?iso-2022-jp?B?a2RROFZ6TmxqY0o4UHJ1QTVLZTJiVkdhd1hnVmxlM2JFa3RUb1VTV0Ur?=
 =?iso-2022-jp?B?R1luZkQyQnVlUVMvQW9uOENDMkJhUFNJYmVtSFNZendGWGg2aDdtK01C?=
 =?iso-2022-jp?B?M2NsMlhqNUIvOGJSRDU4OEh3RHN6bXJvN3NPY21QTjBWdEVSdnpLSGlF?=
 =?iso-2022-jp?B?WHZRY3I1NlhLb1NhTzlOaWdTcnFQdy9YU1k0T0xiTWMzSUZ2WEpQSmtr?=
 =?iso-2022-jp?B?LzZ2eUhLQ0lLOVhvQ1VObG1XYXkvNkw2VHpZRmJCNVgvSVFpSjdIeG50?=
 =?iso-2022-jp?B?V2V0blc5d0xmOXAvcS9oaXkxRk85RC92UDVPMGtVNXhGbnM3U3IrcS91?=
 =?iso-2022-jp?B?cGMzNkZrK25XUjZEdjNkcGxzK25FLzNTKzhNaWEwOVo3WEdtYVNKWlJN?=
 =?iso-2022-jp?B?bUp5MjRGZ050WTlBa2UzYVEyQU53c3R3R3Y1a05wUHlSQzZyRHBmVC9a?=
 =?iso-2022-jp?B?T2dXdkpmN1dhSG5NUjN4TVFRVTdxZmlaOWwvd0VhRS9qTGcvUUNJdE04?=
 =?iso-2022-jp?B?cFZkNjE2Q0V6bG9yKytjZ1daWC9oVThJWVRaZ1NETXNDL1QwNkNVeGhT?=
 =?iso-2022-jp?B?c1NkREp2Und6RjBUa0JiaEF0Q1F1a0pjeU9QeE1Gekh4YmoxSG01RDFZ?=
 =?iso-2022-jp?B?NUxBR1hZTjVSTHRwZ2JCU0ZidWtnRmpzYWRHMzVITHd2UkNCK1hyaWNl?=
 =?iso-2022-jp?B?S0pFVW1Jcm44T2dEazZEQVZFTUxFQjZZNjdNSnRuUXNXMDRjQVMxZ3Nq?=
 =?iso-2022-jp?B?amw1WERTeUFGbzZPTkprdXpVV3hkUFdNdzRqaSsvWW5pN1E2UU9PeE5k?=
 =?iso-2022-jp?B?UzFXcnc1QzlRNDBEQkpOOXFmN090TGE4ZGUvWmhBYlB1bG9hc3YvVFND?=
 =?iso-2022-jp?B?NzRKZ09GWHdrV2tSQUhvQkcvWElaOWtKenIzbU9jdlRVZ2lwVVRpNlNl?=
 =?iso-2022-jp?B?RnZUc3lMSlNPU1BQZnU4U3l5bDdFZzY0WkkyYlVjbWlwY04zektYMWpa?=
 =?iso-2022-jp?B?VFFkdTF6SjU2ZkxBTStpZXRDR2tvS2RJbkNnUGdGMW9WZnFZeHVBRS9t?=
 =?iso-2022-jp?B?TDBHSld6a3VBMXhiOExHWnhmb1VKay9OamUvRi93aVcrWWlxTHZISjRX?=
 =?iso-2022-jp?B?d0Y3QUFiTXY5c1piVjVoeUptWTVwMC83NklRb0ovUUwrR1UrS242S2I2?=
 =?iso-2022-jp?B?K1NIY3pqeHVwa3VTcHF3cGF2VTJWaHJycHBGdXAreUYwOUtQeS9keUJR?=
 =?iso-2022-jp?B?RzVoWWpDMUY5SjhraE9Xa0JlZHZHTkF4dzZCT1RNNW9uUjNrd1hieWlW?=
 =?iso-2022-jp?B?N2hHbU1vaDdJNzRZWEVMKzlLa2xPNTU4TWRTdE91c2xRTXlSS0hJRm5O?=
 =?iso-2022-jp?B?WmhrMGVYZkpEZU9hbUlkOHNlbHlqaFcvMURPR3FObGs1TCtWZlZncm9o?=
 =?iso-2022-jp?B?REZJRFdVK1czeWN5YkZ5VXVmV3UwZk5hOEwveG9nNXVwblFKdm1UWTFV?=
 =?iso-2022-jp?B?ODRIalZ4LzZlNVBLaWlUbHpUeXdxZGRKajBubktZZjFCc1ZtWkxBM3Mw?=
 =?iso-2022-jp?B?VkZXMitGVlVpaCtIQWRJK0IvSDRLbjJuNUltcFVod3g2dUtXNW5DSVpI?=
 =?iso-2022-jp?B?cWZqdCtjWGdwUTRsLzZwV3hWZ2tRUm5USjkyRWhKd2h6Zk0vb0xZZW96?=
 =?iso-2022-jp?B?Vk1zc2ptanIrejNad3dCb0owVFF3RlhDemV2bVd3RnA4N1hBaDMyK3Iv?=
 =?iso-2022-jp?B?Z3RIdWVCajcyMFl6Y2U2MDU1THIzeUgrQzVqV2lIUU53amFiRFkwb3R5?=
 =?iso-2022-jp?B?RHgxSG8yRUNSb0V0UHFkdElweEZuMUN3a2JuOXJtS21GbDB3bWdSU0Yr?=
 =?iso-2022-jp?B?Z0VVTFZaWW9La0RRV0ZyNno1VVNkZzJkTHh5SzE5UmRLODV0blN2TUE2?=
 =?iso-2022-jp?B?S0Z6cmtHMDhCNm5TZS8ySWhodkQyemt4MVE9PQ==?=
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
	TQ1E9eGdrhaDeozOu5ERH8jkty7idlYLrqWNUKOC3cDqbIT2W8e2jkESzMaIHmHC/Suynkd7ZOzspoPNYd/o74guIvuHoVsbqaOe/UQJhSioj6DWHA3MpStzzYR3IEOGDeBUMkV/U3HKIpofcUeC11hh7CVFMnJq9WkiLfnBmDXcvqecHaIQ4Srz2oLbl95/O8OjNyojxFoMoNqefqIQAjtqMqw/JSMANQOc7DtvDt8KR2DLZ/wZKURUbE9JC/RCmPNA+laa0WnCJdInfUUndbvgKd31O6VWanPFRKQWX4qNSsquShlJZOCHHk3Ihi55QxtaH45rIuLPuP5tXqPHLIwIkgwwWxCzAmpGR8VlyvyOa9SG1IKB+KeT1LAE95Sxbf2RL7nqc8vpb2H6YANOflCS9RCpdXjIExl+oHndESVOL49qaB/pD/faXILMbuObj+4VylYznS/Rv9azAHteCl46XDoz5nAFERn59aJYu10RAOGCvpggivCeX1pCcRD4F7ZOOqJ4iZka3di8hwTKnWeD/N9RT4PxK+cTV0Rj8RKNLM6c4GxHejKlTIlBvHuQW0AbAHfQ63tMX+nrUrF/+2kRkVI3WE1MagPikZ6Ev9mz6MP0c4PzTsK9Lh9kiSi5
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8c3cb7-e909-49a8-3ed2-08dc9efa0c48
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 02:59:56.4263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2m0so4wd1RgJDCj5z5TF+RSxF0CyluGnBWb8VX4CfuDtHwgZ2AnLbaflKIQ1RV8R5uIG4w2xKtg40SWK+PnPT9nMg1gwR+sF0RpIzLibIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5442

Kobayashi Daisuke wrote:
>=20
> CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards,
> the link status can be output in the same way as traditional PCIe.
> However, unlike devices from CXL2.0 onwards, CXL1.1 requires a
> different method to obtain the link status from traditional PCIe.
> This is because the link status of the CXL1.1 device is not mapped
> in the configuration space (as per cxl3.0 specification 8.1).
> Instead, the configuration space containing the link status is mapped
> to the memory mapped register region (as per cxl3.0 specification 8.2,
> Table 8-18). Therefore, the current lspci has a problem where it does
> not display the link status of the CXL1.1 device.
> Solve these issues with sysfs attributes to export the status
> registers hidden in the RCRB.
>=20
> The procedure is as follows:
> First, obtain the RCRB address within the cxl driver, then access
> the configuration space. Next, output the link status information from
> the configuration space to sysfs. Ultimately, the expectation is that
> this sysfs file will be consumed by PCI user tools to utilize link status
> information.
>=20
>=20
> Changes
> v1[1] -> v2:
> - Modified to perform rcrb access within the CXL driver.
> - Added new attributes to the sysfs of the PCI device.
> - Output the link status information to the sysfs of the PCI device.
> - Retrieve information from sysfs as the source when displaying informati=
on in
> lspci.
>=20
> v2[2] -> v3:
> - Fix unnecessary initialization and wrong types (Bjohn).
> - Create a helper function for getting a PCIe capability offset (Bjohn).
> - Move platform-specific implementation to the lib directory in pciutils
> (Martin).
>=20
> v3[3] -> v4:
> - RCRB register values are read once and cached.
> - Added a new attribute to the sysfs of the PCI device.
> - Separate lspci implementation from this patch.
>=20
> v4[4] -> v5:
> - Use macros for bitwise operations
> - Fix RCRB access to use cxl_memdev
>=20
> v5[5] -> v6:
> - Add and use masks for RCRB register values
>=20
> v6[6] -> v7:
> - Fix comments on white space inline
>=20
> v7[7] -> v8:
> - Change the cache value to offset
> - Access memory map area in rcd_*_show() functions
>=20
> v8[8] -> v9:
> - Map the pcie cap in for all the time the driver is bound to the device.
> - Add mapping the pcie cap in cxl_rcd_component_reg_phys().
>=20
> v9[9] -> v10:
> - Change a utility function for getting PCIe capability.
> - Fix tab alignment issue, error handling, and apply suggestions from Jon=
athan.
>=20
> v10[10] -> v11:
> - Add functions to have one function do only one thing.
> - Add a size parameter to utility function arguments and consolidated the=
m into
> one.
>=20
> v11[11] -> v12:
> - Fix the error handling in cxl_pci_setup_regs().
> - Fix and clean up some details.
>=20
> v12[12] -> v13:
> - Fix and clean up some details.
>=20
>=20
> Kobayashi,Daisuke (2):
>   cxl/core/regs: Add rcd_pcie_cap initialization
>   cxl/pci: Add sysfs attribute for CXL 1.1 device link status
>=20
>  drivers/cxl/core/core.h |  6 +++
>  drivers/cxl/core/regs.c | 61 ++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |  9 +++++
>  drivers/cxl/pci.c       | 89
> ++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 163 insertions(+), 2 deletions(-)
>=20
> --
> 2.44.0

Can you merge this patch into the next kernel?
It has been reviewed and I believe it is ready to be merged.
If it is already in process, please let me know as it is my fault for not c=
hecking thoroughly.
