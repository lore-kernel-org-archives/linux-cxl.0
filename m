Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B460116D9C1
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 23:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830207; cv=fail; b=IuBIRyOXpzffgbsAfyTmATZlned6okatfdDx+MxUpN+oLdCoM20F4sDtHIpR2b88v7Od+XwjMybzQwybMMxjFFd49pDuyNvUNdZ9HKClnhjLBIvCssA3YxjwCGGGQxMwCiEVWe25btBrYMnKqHs0VqQqBamCOoN5jp/14Qp0LHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830207; c=relaxed/simple;
	bh=ecdw22M3bYOz2I5jqOjDXvad6cFdOmHEBCrMEOMdP0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SNW3LH16DrCNORsCPUfQcnMRSKD2AbMKk0A0JpG2yfVgz5CZXqkkzvXs1w0KSF1Ob674eBI6jJg4dK+fSOpmJM2KtuGe21AdxOn3IQ6T1KWal3NpYqNVeb/RxgJzk4V+oSb2DQbJCEeq0oQgM1c+nrvHUpPRoTxPJ/VmG9jl9SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=xLxtXexK; arc=fail smtp.client-ip=68.232.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="xLxtXexK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1713830204; x=1745366204;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ecdw22M3bYOz2I5jqOjDXvad6cFdOmHEBCrMEOMdP0o=;
  b=xLxtXexKkJ+NYfsWZC3Q2gm8MpoPtSVWmsvQ8L9dp23KjHZUkIaaEcJ9
   aBEec8RKdgQC87PFBvye7VY5iLeB2JcIwK24jGwSVp2RXvVRSXJcl06FE
   74z7QhhbFDspHI02N/8BeuReO2S0b0K+y/fhPqC1Et/3ya5Oqh8mhMWTv
   o/s8YRJ5iMjTh+PVYo2aHUwEvVq6TaKkg62j1kp1oPW5xiX1dYMPqN+Ru
   Q2z55fYNmt/sJu6X7KQncF4M+13E1w7spv0ykL/5z+8AedXDfBwJk5o2K
   VEoeJCiq2Fhja9pH7OnCaAqlRM/D2krEQP6R6W+j1t4uzjfkmRnCpp4qn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="117557030"
X-IronPort-AV: E=Sophos;i="6.07,221,1708354800"; 
   d="scan'208";a="117557030"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:56:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHDwPVUvznMX7r+lVQiCWvp0n+NUG5OrjcdwbI/lYNoud1ZzDZSIdATmu1kRZo6QjTOBkL+/4SjxBrtoq+Gbab8OQ5I2WhQ75Wy5I03OBOkpjxNvQ7Rw2ur6AREutNmQ/o70dE6gNHZGUMwC6sDpAcnBBbmxuVsnGAXndfakzPQTpeVrD536PqzcX/zpvmhdEC+lGvi6MndVOl9YAWe2zVp9rqCBodkqZUZPdB5Q56/QyhY4UJhJ/LBUOdsS/LsE+u5nU+ocg/FAIgONdAAL8+BuXflkOok05v1zypiMc8vGOYRdtZC+XaL1zWFMGo4Y6RybebDVffwzZ9IQBHzipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gs8Mt1a4EitMYk2ieVnA835PB+ExdhQqXr3kyo4i7as=;
 b=Q4cmD0aQcr5ocMoNt8pRWifrSjyYHMsnSGKBIWsir4IWhkEeG7W0qoDjdt4Y7epShrtrOpg8XmZvSQhbkh3Z1q2PlWdGMzIn0Aohs7X1GsUycotYRWsuoBfXIdg/bYLY9+nF6qyXH/QWaChq1r57NivB4TOmY5/SLdgXLDVsV7MLjIxBpPyItDOPRYH/sGYJEo9oRDMHPFATkfwialTpQ9Z+rh4lSUSUG5rUY1bUfAZ0V9yfigK5+jJ+7KjPp1HRRQSr1PxohgSyNfwI6yMwTyJ3dm1geExx2I87HgU+u9JcYa5jMEBQ+gMUyx/07EZQCo4ulAJ8B8SfT5kntOV3eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYWPR01MB11219.jpnprd01.prod.outlook.com (2603:1096:400:3f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 23:56:30 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 23:56:30 +0000
From: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] cxl/core: add passthrough flag to struct
 cxl_switch_decoder
Thread-Topic: [PATCH v4 1/2] cxl/core: add passthrough flag to struct
 cxl_switch_decoder
Thread-Index: AQHalJV7MTfLE1ff2kmBa8IiKUfojbF0IrGAgADUWlA=
Date: Mon, 22 Apr 2024 23:56:29 +0000
Message-ID:
 <OSZPR01MB6453787DF88D2824F3D2AD958D122@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240422091350.4701-1-yaoxt.fnst@fujitsu.com>
	<20240422091350.4701-2-yaoxt.fnst@fujitsu.com>
 <20240422121215.0000344c@Huawei.com>
In-Reply-To: <20240422121215.0000344c@Huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=f53164fd-8b7a-4499-96fc-83defb57d3a7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-04-22T23:52:22Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYWPR01MB11219:EE_
x-ms-office365-filtering-correlation-id: 91d7057d-f0ba-4e17-e375-08dc6327d48a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?NHRsVEhNN1NuaCtDbHZCekl4RUxETDN6UzIyV0g1ZUZiMUR4eFBIWXFj?=
 =?iso-2022-jp?B?UGFZd2pIYnBCNWdXaktiOW9sTWFmRmltSkxCN0M4NTVsNVIwYzRnaVIv?=
 =?iso-2022-jp?B?eGxPZ3NPMWExWWFDRDdtUFZtVXE1RXVhRlNQYXM5QnJCaEpZZlhJTkdk?=
 =?iso-2022-jp?B?YWVKdGtBZHNJSExmdjIxOGhIbUJHWTNzWkllMU5vRnhRcXVFNkp3dURP?=
 =?iso-2022-jp?B?dkY5MmRqMlRia1EyM0RxdWJuZ2xNMWtjNStqdlU1S0Z0STVwdGFpcUJH?=
 =?iso-2022-jp?B?QkkwTURZRHByZDIyVW00YlRiSEVlSnFTdTc5NlpRdXhZaytVK2VJM0l6?=
 =?iso-2022-jp?B?RzVxTU5nbzFadFY4cHVyMG9ta0d2emdqbCtVdStLcitzdWo1WngxRXcv?=
 =?iso-2022-jp?B?SmVpanBWK2VHdnFOZkxkSldNZmJuWngwZHE5cG5lSHRuUzg3ZGdaQW5G?=
 =?iso-2022-jp?B?aDNnK0ZlYlMwWGUzWG1kZkxIdGNJbkY2MFY5MmZrMGd4bXRLWWlaWHNt?=
 =?iso-2022-jp?B?c2l4NUdEQmhUdWhDaXhKQTRya01RVFM3UVh0c0kxNk8rb0tOTUhjSWg3?=
 =?iso-2022-jp?B?ZkRmaWs0bDZMdldVQTl4Qm82a1cvdGhaL3VmcEhQeCtHMUJFbWQ3L1d1?=
 =?iso-2022-jp?B?a0NGTEFRZmtVa3ViUnd2SnFoLzgxTGFmei94N3FsdDBSR3d4NjhSVzFU?=
 =?iso-2022-jp?B?OFZKbVlaSndkcXZOOFRvbC96WmtJM1FyTGFiU3QzSnBLcGlmc2ZmR053?=
 =?iso-2022-jp?B?V2R4eXRvTDE1c2NGdUx2b1Q0RW0wYUpDWU80MFRGdFJVT09UNThSd2Fr?=
 =?iso-2022-jp?B?YnNvS3VrNlpHVVkyWWdSUmo3Wm5mdHh1R3F6SjBqYkxvTlAxZXNzU3d3?=
 =?iso-2022-jp?B?dDg1bHUxemMyOHZNTFdOOThYNE9CZGFyZVZVTXhraXRYdTBxMkxHUmxp?=
 =?iso-2022-jp?B?YzAzQlEwZGpvVU9VM3lYYW8xMHVuSWpiSWtwZFZFSk8yWTJkTjkvUERw?=
 =?iso-2022-jp?B?YkRSWHVLMkpVemlHRnphM29PR1prMzBJWTZYMnFXV1Yxcm9ZNjYwUmI0?=
 =?iso-2022-jp?B?ODFTNHZVQko5cXdJUkdZaEZpdGplbi9RN0NIR1dBc2NQMEpVNXNEaVhi?=
 =?iso-2022-jp?B?d2FMQUdQUzdNQy8wbmFEb2xrTFo4ZmdyUnF2NlcvbUNEamI4aEtKS2lZ?=
 =?iso-2022-jp?B?aDBOWHIydGMvanN4bUMyVjlYTk1nY3JwUUFYbUhHd1Q1bk5QVHpFUS9a?=
 =?iso-2022-jp?B?Qml4bEt1eEVGbnI4U1AyL2h3djhCVGFXdjF6ejRGdldDZDNSSFB5eExr?=
 =?iso-2022-jp?B?TkFIVFRCVHRmTThwQi9iTXUrWjQwemIxL290bzVxdHl0T2htMHBQM0xh?=
 =?iso-2022-jp?B?b2Z1TE5lcndtVGFXY2d2VnNURzdoNGdiMTNMejR2TVd0cnVvMTJWSE1W?=
 =?iso-2022-jp?B?ZzZHOEpsNG1xdFdlUkhSbFMvd0N2S3cyYzNJZ3lNdDFEYVV0NEprZVhP?=
 =?iso-2022-jp?B?dkxqcTVBdVJYZUVxSmFRT0VhaTRjMk5WYkVtaDVRK3Mrc2VtZzY3RTRt?=
 =?iso-2022-jp?B?bDdjTlQ1T1Zsc2l6M21XcmFPUkdlSW5ITXNOeVliTlRXMDRsSDFqc1lS?=
 =?iso-2022-jp?B?U2ZMS3hJMWZySUhUaHNPdnA4NDB0Y29EWHBOWEZuVThKWVkycDRDZUxF?=
 =?iso-2022-jp?B?VlZ5UzRxK3BPM0xlQ1dCK3RkbWZTWm1DTHhicXlOdzRHaFZxZ2dYMVlB?=
 =?iso-2022-jp?B?UDdVM2pNWTlaczZtUGR2ck5oeENHcWliMDBUSzVtT3dQSnNDUnRqdW5U?=
 =?iso-2022-jp?B?STZ4dTNkSEVjN2owQXJKemtqdno0S1FOc0JRaklPUHBkVjlKZUlrVmRX?=
 =?iso-2022-jp?B?LzYzODdvc2ZSR0ZyNW55eGlLbkNnOHN1bU94OTFPVzZaaWliUXRPeHpt?=
 =?iso-2022-jp?B?Q1F1cm5aZHFjRjZCN3B6L01kUEEyRDVYUDRlaTM0dGxIL2lPT3h2VWs4?=
 =?iso-2022-jp?B?ND0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6453.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?TjhVQ2lCaHpwRk1HeGMzVW4xcHFjaThMTyswckk4ODk0K0dPSVordGVC?=
 =?iso-2022-jp?B?a3dSWk5iazZSck5wYXhuKzkyQWMvT1ZMbHRRMnBzYzlmeUVDNFFhWmo5?=
 =?iso-2022-jp?B?SEI4aEs3QW9FZ3BlbXdETGQwL3lTa1NoRWxtTEN6eXdTQS9jaDlHUG9q?=
 =?iso-2022-jp?B?Q3VFenV3VzUvaXk1SWFadnI3Z2lOUC9QLzNoTXR6b1B2OVJJRCt2NGRU?=
 =?iso-2022-jp?B?YlpsTnpLVkJLK24rTHBTcFg1aG5mV3hteGV4S1djNGZuQVFHYkIzeWtX?=
 =?iso-2022-jp?B?UlgxRHQyNzM1eTZyOXBvNWNyczVIOEtMcHNvd3ZnTnVhN296RExoWnlL?=
 =?iso-2022-jp?B?R05pQll5ckp1U3VzbkpkekFRNlRDZkt4aDlRWGM0RXpvaG5jLzc5RHBt?=
 =?iso-2022-jp?B?Q0V0d2FSS3hhbEpSQm1udW5SRFdKTmRxUUxwZHpES21qZmZ3OW9ZQlky?=
 =?iso-2022-jp?B?bTE1TkVPUWNYV21EdStjMU5YUVJkdkxBaU1QbFJRc21zQlUwc1VuSzRu?=
 =?iso-2022-jp?B?RUtPTEtWUExlMXZvZHNGbXl1L0thUi9sTW9SNkF5enVENmJ3NHd4OTg1?=
 =?iso-2022-jp?B?eGQ2ZXByZ3ZtOWJCY3JKK0JiODlnb0VsTzVmR3FVUm5PU0tiTSsyUkM5?=
 =?iso-2022-jp?B?VlJFK3JWZmZXNmdyeDRrNVRxeUh1OHBoUmdSK0VhMjR6VW5uZ0pyRXVw?=
 =?iso-2022-jp?B?dWs2cExubWdwRFJwMytJSWs0ODN0RldIa3ZpRkgrZkxUQW1QeFBSWlZz?=
 =?iso-2022-jp?B?WHNmZmZCaWdjWUZDODZ6MHhOeTN1YUVEM2ZQQTVRd1BNY3RLcHN3ZExx?=
 =?iso-2022-jp?B?U1JzUkt4YUtTdUtQcmE5MEJvWlVxd2ppVVRmK01YeFZDQ3ZxOVFYQ2Nw?=
 =?iso-2022-jp?B?NnZQSGNSc0pZQzdMdlBBTXNLK1daaEhmU2ZhRm05UWp0UWkxY2hNK05n?=
 =?iso-2022-jp?B?OUxDOHhQRHhNald3aUpvMFdidDl6YTdYTE8wUFl3Zi82SGwvcTVBZ2tJ?=
 =?iso-2022-jp?B?Mkp4OUtYRGtOY2kxMGtzUkhOb2R4TE9yNDluUFR5emRhb2dqc2hpWWdh?=
 =?iso-2022-jp?B?bHU3WFIvcHhWZFhSQm42SVJTd1dwT2lpb0pLSWtqc2x4NWZNZmdhejA0?=
 =?iso-2022-jp?B?REtHUDVVUCs2V2FNUnhrZ1BJVzBSRXIzNzVJeGF0eStXci9nUW1UaEUz?=
 =?iso-2022-jp?B?V1dzYXIvWnVaMDJkM1NaU1VDZG1YMzNrVWtPcDhkaFBDUVdoYS9vT3B6?=
 =?iso-2022-jp?B?OTBIU3F2OGdnNXR3QzZjU1dnbk5VVWFNczhHLzNCS3VJK1FPcmhNUHZy?=
 =?iso-2022-jp?B?VkhIeHRBd21URUI4ZzU3aEVSV1dHOEI2V2tHLzVPV1RJWUlGNElQQUJ0?=
 =?iso-2022-jp?B?aFo2VGtVdFVrS3UyYWg4Nm81TktZZitrbWpVYkE0bUg0aWxFdjFGUVZ0?=
 =?iso-2022-jp?B?Q3V1MDhjaEdQM2RXOTQ5aWt2VUJPbXlJL00vYmxUQ09uMVg5UnRVOGxi?=
 =?iso-2022-jp?B?R2xSY211TU1SNVJUbTZTSE5ISEhrNE5QcllBUmwxZ0d0MWZpOU1lOStL?=
 =?iso-2022-jp?B?c2pJUlVvc0xsMXk4QUZMWXBBMUtMZ0FtVzJmS1FPaVhiUWp1TllUMEg4?=
 =?iso-2022-jp?B?Nm9nUHJGVHdjNGRLMlg3bnB2Nkk5QytHalloK1dPVjZzZFhid0JBU2FW?=
 =?iso-2022-jp?B?U3NRVW0zMGdTdEJVREkyd0Nud25iOVpHWEpqQlcvam5KajV5MUtvVmQ3?=
 =?iso-2022-jp?B?N1BkUklQVElPWmxrY0JKVzgwdVVXdEMxalJHOHlNdHFXVEpmdFJVNEZ3?=
 =?iso-2022-jp?B?cEgwdmZjanpSdGFIdHVPWWs2QzUrd2xTV0pFbGNLS3JSK0dzdTZnMWpj?=
 =?iso-2022-jp?B?NDc2YnlyV1VvRWhFeVpudVZtQUUwMEVZdjM1RWlSM1dyZ1ZwUU9QV3R3?=
 =?iso-2022-jp?B?RXFWVkRKMVlUOGRRZmc2b1MvZmxQNWdYeCtzRDNVMDhaam9TRjBUV0Ew?=
 =?iso-2022-jp?B?RU5VSjFwZ2xtcGlQNkErRHRHZ2dCbXl2MEN3Z01OSGdtSHNxbHlxMThD?=
 =?iso-2022-jp?B?ZE1rU0JFMEcyNHdIa3poYi9kZ0Eza0JDT2NMTk9VWmRrVnJieUtGNXAw?=
 =?iso-2022-jp?B?QlhsdSsvNWM0VXZvWSsrYjFqWmJPL3JSMVdSTy93WDlUcElxRXIwc3pk?=
 =?iso-2022-jp?B?YTl3RFhMWDBMVE9WYUNWV3Vxa3ZLOWxTSkkwYmdmZ0owbWRmNTRHT1Ax?=
 =?iso-2022-jp?B?aTJzbENmWDIyZjdxc01VWWNBaGpjeW1UZGlSVG5zdy9lazQ4eS9kVmND?=
 =?iso-2022-jp?B?UnhNbA==?=
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
	ep7Z+GKrnnCDHJm0GOquq45nmgFH+kNCZfYwTjz7ZmC9fW4nblcj3JyInmuUy9ZzwJs26wlTMoWQVwhDo7fv89FOUvtgP24KMFuAh+NxzXUiixIDuRhwWLe5a9PzMJqf2BKByXEy3wwwBl/WADHqD42wF84unQvABcQdPAPJiYvpj2/tjFKarI5nX9C7Wj0uesAZFq06hpE4+cVT8Mds43n9HpdRD682zk+kiUEbuHxev+k1XJQ7C9a2cm0fc4KC0OLOywwgFP5x/pUy9BOtA0nNb0o73cIl6c3MVrKKxYL1OjRiBYcbSfUlMkbuDM+3nZo/aEoXT7HxcSaaFf4se4GvHJV1UenMpqa6sHggp1ztavWepdJAUjeFb2gj3NbRYLIUjL0/HnaQSZ7uMPU+Hq1TNoAnZe4uaY7WvTASca8VSekLVrFB/njg5bG3jJa43+qfeky8Dw+IGeWnhyjhSaLrs81oKQFSpGcNfi+LnrIAB7xC/IPkH8zznuc5FEws6kLv1juSE7JpLgSqsiNQZV6Dtfutq0VCm5oyJGO+2z9CsP3E7l1pcb8a5xn+SK5aSc0HxNavNoMFHXLX5KaDNKStwiH6pR6bIOdjY5K1FAc/lAu11yJLhy+b2X5gJ+yz
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d7057d-f0ba-4e17-e375-08dc6327d48a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 23:56:30.0302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qovjbo8IrDDJ6E6u3rv6fwoEquGjYrlVuGA82A2k9kI/n2CLFKf1Lsc1d0amcqWE5c1ZDFwKYJsInAF06xEBPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11219



> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Monday, April 22, 2024 7:12 PM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>
> Cc: dave@stgolabs.net; dave.jiang@intel.com; alison.schofield@intel.com;
> vishal.l.verma@intel.com; ira.weiny@intel.com; dan.j.williams@intel.com;
> jim.harris@samsung.com; linux-cxl@vger.kernel.org
> Subject: Re: [PATCH v4 1/2] cxl/core: add passthrough flag to struct
> cxl_switch_decoder
>=20
> On Mon, 22 Apr 2024 05:13:49 -0400
> Yao Xingtao <yaoxt.fnst@fujitsu.com> wrote:
>=20
> > Per CXL specification (8.2.4.20 CXL HDM Decoder Capability Structure in
> > r3.1), the host-bridges with single port and switches with single dport=
 are
> > not affiliated with any instance of the HDM capability structure.
>=20
> To avoid any confusion in future, this is an option, but even with single
> downstream ports they may support HDM decoders.
>=20
> >
> > Driver will add a passthrough decoder for each of them during init, so =
the
> > constraints imposed by the HDM capability structure do not apply to the
> > passthrough decoders.
> >
> > By utilizing this flag, we can swiftly ascertain whether a switch decod=
er
> > qualifies as a passthrough decoder, thereby avoiding the need to conduc=
t a
> > string of capability constraint checks.
> >
> > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> With above description amended to reflect that it's talking about an
> implementation option.
OK, got it.

>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> > ---
> >  drivers/cxl/core/hdm.c | 1 +
> >  drivers/cxl/cxl.h      | 2 ++
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 7d97790b893d..27fb4f9d489e 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -57,6 +57,7 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port
> *port)
> >  	if (IS_ERR(cxlsd))
> >  		return PTR_ERR(cxlsd);
> >
> > +	cxlsd->passthrough =3D true;
> >  	device_lock_assert(&port->dev);
> >
> >  	xa_for_each(&port->dports, index, dport)
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 036d17db68e0..6f562baa164f 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -415,6 +415,7 @@ struct cxl_endpoint_decoder {
> >   * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
> >   * @cxld: base cxl_decoder object
> >   * @nr_targets: number of elements in @target
> > + * @passthrough: indicate whether the decoder is passthrough
> >   * @target: active ordered target list in current decoder configuratio=
n
> >   *
> >   * The 'switch' decoder type represents the decoder instances of cxl_p=
ort's that
> > @@ -426,6 +427,7 @@ struct cxl_endpoint_decoder {
> >  struct cxl_switch_decoder {
> >  	struct cxl_decoder cxld;
> >  	int nr_targets;
> > +	bool passthrough;
> >  	struct cxl_dport *target[];
> >  };
> >

