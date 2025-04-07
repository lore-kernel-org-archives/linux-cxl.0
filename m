Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A21F256D;
	Mon,  7 Apr 2025 02:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743993108; cv=fail; b=b+YrlbitRNkg/WXYbpbqDyZ2JleEYkAJOycOSkn4/6QwvoWbaRvsaN9My9UBuP21GsQCPkUgT4h6NRvJpcrqmeYaUZju6Lb8va/F1iWY8V1NXWsT+UKv9N7LJPkvrdkCNlCiybytWLELoIbW4WOLtnVS8DWcQUKGDLAk/LktmyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743993108; c=relaxed/simple;
	bh=NqkR1gHALWN5AhUMbeTVr8w08whewZ/Dxwjf2lMxRZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fFC7OGVY3CeffqrkmACyd4wJaYShwsMy9APB4KYcxbEXYXn5pdAdeUvpMwCiPSvLnaAdeiXQqwM4Os4nk66cKQNEgUpUz5Z6Y9UTy9g3g6y217RSS2jmXS8pbCyYipewn4qnCqEptCc+MIZsPe+PDfpij0/0spFuxUw6s3Yzqxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=luQw3Thh; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="luQw3Thh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1743993106; x=1775529106;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NqkR1gHALWN5AhUMbeTVr8w08whewZ/Dxwjf2lMxRZg=;
  b=luQw3Thhrjx8wVxkzqtnPV7R1yB3cajt+pmANqMb1ZXujODrRI+/zJM5
   Ly0FEb6lK8MbJSZ1hrUakPN/uN6q7cyfRtFYRka/NJCXCT5USGM1E0jt5
   qxkQdWHPeH8TBkDnXHfpEvbx9fuuRml2Pbvyr9xRT0UZ/37vJ081m85N/
   0GntCham6KNRBXvKYLDd6LJOLSw35pclB4BYRJYomQu6G2xvzLeVVirzp
   FZGkUx5NTBt9q37KzAvvT5zclPA9wW+EdKT6kArqckbCO7LAObdv34DY+
   EisAFOE2e27XJKIApPw4geGuYN9/opXAB+IdmPozyk9rPn5HlNFU3KaCT
   A==;
X-CSE-ConnectionGUID: ldvNsKYVR2O8EcKY759Tig==
X-CSE-MsgGUID: c28w6WSKTjy7VFVmzTb+ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="151531150"
X-IronPort-AV: E=Sophos;i="6.15,193,1739804400"; 
   d="scan'208";a="151531150"
Received: from mail-japanwestazlp17011029.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.29])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 11:30:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfapiMUx/aRLAcRETTPvHwZ/g6OEtNNRkBHI0icjZB40D+DUWOlkH3ggedj4i+b/qjzJi3m6M2EBVUzakwUovBQCJYOtIQ9jz0uOuHGXIuGoPnplcPUSIZ8IfH3sE6VK5S2RQySJemkCUJ7C2P/P2lsye/ttLcEpQNI8o9MeFYchhiIoQVt/lhsmgsDk1MngtmiZfNWUBJ6XtsuBzEEXfd7US55nazymnhUkhyoIU8oInGk1XDe09pEJxpHvgX6FWe+W2+VhXd6sXumlfK0aT5OIabzgmaGzV5DU02dSq1lDkwyrI5m3F4aKDRflLDx5L7inEISm67CKDYUOGR60Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqkR1gHALWN5AhUMbeTVr8w08whewZ/Dxwjf2lMxRZg=;
 b=XBJ63fpCsqXhM3riDhXvDYg8bk9QJdFLXeXDZHEMMZYS9gW2u75ZHSCHITawpXAaBQjeOuDVP2pwMJ+hsFzKu5Ej72KW8EpgqldtC1VBi255e3eOobIRMtboemOtXdAxopXYwQKdO0fohib8upKMgyzEEQ+ZbQC1HcJYxWHz2HXfUUAqRich3bbGRoUgGdaYUMEQ96f31WXopbABuRjzQILzgN9UYKRWu39ulW6WpR8r2GvKlW+IAMLm3nQXTfOIB+aXuHlmvx3GHvBH4eKi32Mja9Flmf5YbClUGSrQ4UiQxPqHSKpSQ0Ol+uHyFetNionbJqqOxosTp//BrKFjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYYPR01MB6572.jpnprd01.prod.outlook.com (2603:1096:400:ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 02:30:24 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 02:30:24 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Verify CHBS length for CXL2.0
Thread-Topic: [PATCH] cxl/acpi: Verify CHBS length for CXL2.0
Thread-Index:
 AQHbniL/JoX3x8SxXU+HvSvJEGqce7OGWN8AgABC9gCAAGJBAIAA9aMAgAwvPYCAA2p5gA==
Date: Mon, 7 Apr 2025 02:30:24 +0000
Message-ID: <038bc7b2-ae01-4d47-aa73-659b9cb8028d@fujitsu.com>
References: <20250326074450.937819-1-lizhijian@fujitsu.com>
 <67e4c9aaedd08_138d3294ca@iweiny-mobl.notmuch>
 <1ed912df-42c7-4319-8765-3167963df7b3@fujitsu.com>
 <67e5544237027_13cb29432@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <7bbf602d-6900-4179-9737-efeb40e1566f@fujitsu.com>
 <67f05aeb50ea_464f7294fb@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <67f05aeb50ea_464f7294fb@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYYPR01MB6572:EE_
x-ms-office365-filtering-correlation-id: f00674cf-c527-48ca-0754-08dd757c26be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?eXFjckJoeC9xRC9US2tFcER0WTRHUnNDMFpmSDE3aGh6eUR5dE9Yb2gwbi9j?=
 =?utf-8?B?T3ZaU2xOaDNzSHN4azFvbkhMYnFCSlZ5OGhVOWZGaUh0SWptNkVpSDZFYWpo?=
 =?utf-8?B?ZlBTZnhSV201eTdJWGRFcytCTG1DR2hwNnZDdERqajR0bnU2TXZZd1lmUkd4?=
 =?utf-8?B?aE9GbVloSEJoOVorOGxLVTBZOEEyWjVReEZhNFJEem9rY1RRMTd6SG9rVkM5?=
 =?utf-8?B?Y3Ryc3pzcHc5NkZkaDFMQjFxRm1zWVhISm1CejRuN2VPeFNQcXcwNTc0OHhk?=
 =?utf-8?B?aFIxR0pHSGFQQlN2am1CTEx2QXlVVWV0Tm1nNHlTaUdNblFRZ01pcTY1dnVS?=
 =?utf-8?B?VkZZSVkzSnA3VDlHWkNRZ2UvaEdHYU40WGVqYzlhSy9HM0FkVnpERElFOHNx?=
 =?utf-8?B?blFOSERVUW43dUtHT3kwN2Q5N0s4WE1XNW9TdUFoVC9YbVZBM3BFNXk4Uysw?=
 =?utf-8?B?SE9nQmFvMjdFS2xrNDFZNXR4TGZwU3BhUTJHdS9WWkF5Uk1IWTVFTG1naGdV?=
 =?utf-8?B?T0xkUU9xQ21hVzE5SmpINCs0MWVXbHpQT1JyUnY0eFEvdkZHcjVoT1BndVVK?=
 =?utf-8?B?aUFUMWNlQU1KY2VxYWhuV3YwY3ExRVgvL2hobGJJbmxpNlN0clhVQ0YzOVZo?=
 =?utf-8?B?clg5U3ZUWm1Xd013RExwaytJeHBrOXg1aXU1M2Nra1k2a0p1T01xa2JmQkhj?=
 =?utf-8?B?YlR6eHpOeTZtSFdIdVhOZ3hpWFJDVlNxZ2JSbUd2OXpNSTJwM2Jkam51dUh6?=
 =?utf-8?B?c2ZKNWU5MERMS1p4alRHOTEvU05mb3lqVmtTYUZGZHdzM0kzNldwUUJ5YS81?=
 =?utf-8?B?OEJyUDFIcVluM0hUV2ZsajJmV0VlalpwUjR0S05qa2s0SUhkUVVVTFBTSjZD?=
 =?utf-8?B?ZDVjUzZiMnlXLzJGVk4zdUNMNTZ3UEo4dGxwT3NTVUpIRUt0M0VIcTQxYXF4?=
 =?utf-8?B?TjB4NTJReVpYWldmc0NnejYyYndTY2pnbFRqbVdNYlREUU1mMmtMZjRZaDl2?=
 =?utf-8?B?RldxY2NUZGJtQ1VyWkRnZDQrZ0dlNXh6NkhyZ2NJbzlDdFRaaHRTUStYM1N5?=
 =?utf-8?B?UE9rNVJPS3F4SlRjUTRuYTdCYUFoVlNPWGw0WHIyb0ZWd1VBQjQ2TWxpcStZ?=
 =?utf-8?B?MmJaSkhPTVdGdHBpMnJ1UTFESjhTalpBZjgzNVJTWnNiaVVMWVlwajVpcXMy?=
 =?utf-8?B?VUZEWGx0RzJzS3RqV1RueDd5ZXZMMTdQaWJPVmtPWmJtdyt0ZjErTzVZcFlF?=
 =?utf-8?B?TkRISmtBTWpmVzZJdWZ2VFl6RlgyVnlkdk9BL0tlN2NEMUFjN0VUSThoS2hn?=
 =?utf-8?B?VVNZWW55cUdYa29xclp5WTV4MWFUYWsxU0tSVkpNRngva2M2VnVpSVVuUG1O?=
 =?utf-8?B?NzMzeHpPUTVNRlM2c0RBVlVvZ2tTZzBnZUZaZXRGVVFOSWd6TjRINlcvQVFi?=
 =?utf-8?B?QUt3RzV0ZGVFRFFndGpJYjJqUHlzSmVpcHpVeEcvV0cwTFlnT3B0R3pMdmEv?=
 =?utf-8?B?SDlPaWx4SFRYRWtIWnVYb2VFZURmVzZjdmVlQklHVDhoTHlIZWpFdWQ2ZTJF?=
 =?utf-8?B?NzNvM1JUN01ZQlJUeUtIRzJmU1JyYm4wZjVZdmlUd0YyWk5pNjEybDRWb3hp?=
 =?utf-8?B?S2Z2cGlPK1kzVS85Z2RWT3BQV0d6aGhYTm5ETURCYktjRm5qM09zNTU5K2R0?=
 =?utf-8?B?QnVmRU00U25BWjZKQzlpU0hPTDNKOVVDYlpmdDlrenYxbGVqVTBLRm5SU0U5?=
 =?utf-8?B?eTFlckZGbkxDdXBqMk1pYzRaTDBENmhuSGJGbDJjRjlIVTlrcHJjcTUxdURZ?=
 =?utf-8?B?VTdZNlRyeWpsNktwNjNQMEFFQjRIY3dqWlNJL2dOZ21hTWQwNC9DamxCWlpL?=
 =?utf-8?B?STVyRTVyZXd2RkFIaWxxbzF6Kyt6TWJHMDV1cFBoMytaNi9DV011RERHVnRL?=
 =?utf-8?B?Q1VTQWU0aDdFMjZLT0hkN1pxcGxGRzEwRk1XUGxjSjhKVEdCMWFtWGFQZkpB?=
 =?utf-8?B?ZnIwck5BTnp3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YldjQ2k1cXg5bUJIMEliY0VESHZTb0Y1ai95VDZZMEFWckZXa0traFZmOWxN?=
 =?utf-8?B?VHpuUTEzOGd5ckJQTE1adUt5MGxsWjdpZVhiZUQ4T3lpMmM5YVFKVG1JMjJ1?=
 =?utf-8?B?V0dWR3hPOE50QTQyci9Gd1NnQ2NWSmRTK29rNWdOU01FNk0rQTF2S0RVc3NM?=
 =?utf-8?B?TVJSWWM5N1BVWjlHU0Y0SFZBM2dXaWpnY0VWYWk1bUszUkI5cGIzSjdlZVY5?=
 =?utf-8?B?YVNESnQrdDhhSG9xQ1NVbC9MZVJJbWxiM0prb20zMk5XUU84WjRLUUIrc0Zw?=
 =?utf-8?B?WmF5ZkdLSFBBTjBUY3l6QUxrYi9meXJzRVRqWFNSRlFJY0lVOFZwU3BYc0Mv?=
 =?utf-8?B?TjJGZ3dCU0Q5Z2djSm81ekoxQ3dGLzVaV2t3MWxHT3k4empuMkZVdFZRKzVD?=
 =?utf-8?B?MnFwYzFkeStTWWh3Q2wxQVhjSmFyWnliOCt2ZG4vb25BQy9YeGtrRytkOStq?=
 =?utf-8?B?L3VJT1FvM0NMRm9PVlB5dUNDSktFeURzVGlBaVQzSFZGNythdTBxakU2WEF5?=
 =?utf-8?B?YzBWd3czMG9rYzYxM0tBUVZJeDkwRkVLdWxNS2tpaE9GM0o0ZTJ0VjY0SVEx?=
 =?utf-8?B?YzdweG11ak1McG0zU1hqa3I2bmdrcDVRMXJkRms0MzJ3U0lDSWZEVWFjWk1z?=
 =?utf-8?B?dVRrWGdTRUFPNTNyL09EelJrbU1MaUEyZk5tcGZDbisvbCtpVzJsK1U1L1JK?=
 =?utf-8?B?YnlLOTllcDZHOG5iTHdYNW85dGM2STJVTzNNVlV4aFhvWkM4aXZIKzE3L21m?=
 =?utf-8?B?VS93bGV6ODVlUllTQzBHanBKMnBvcG1oMGZ5Qi9HVVdoK3JSRll4ckFha3hj?=
 =?utf-8?B?VmFPZzhtb0Q0U3dYdGUydm83UmNUZExqbEpBblFMRWJWam8zWGU4Tm1ib0w2?=
 =?utf-8?B?bU04bjlTcEpSSzhvQWVCTUs4eGpPZ0JwRWpuaWlNYkZHL3dPL0FrK0I0NXM5?=
 =?utf-8?B?MHlzck1yc1Uvdm9MaEVnSStNM2NZdjVvWVA3Z3dFckUyaktldDFVY3NSNWxO?=
 =?utf-8?B?M0Z6dU04UU5ua1RMS2Q4THRua1JheE1YVFFjQzU2ZENZcjBUU0orKzlpa3Fn?=
 =?utf-8?B?RG13MGRiTG80Z3VnSUlkcE5TVXpFdk9GbzRXWU9xMGFTT2xRVUtTcGlicG5I?=
 =?utf-8?B?QWJ3VkdpaU5acW1JRWdpRG5GdkZiUDJla0hDcVdhVjVkRGZNSjhyYWpwN3Vx?=
 =?utf-8?B?Nm9NL2F1OWh5cm44OW9uekVvSGRxZHVIT1RacVF3YnI1SmtHWjFkRGdZc216?=
 =?utf-8?B?Z3FmTzB1WFFGbDZybHZrb25hTnRhVnA1eXROUVp3aVBXM3ZHY3pKemF6cDFl?=
 =?utf-8?B?ZVVoT0YrV2ROZmZyNXhhS0svc1drdTNMMGh5dElySE5CQndqMGZLSkRVMXJl?=
 =?utf-8?B?bnpMMGpEN3pMODBFbXQvRnBBWnp5T3dFamxqWWFuRXhQemFsVEtQN1hPb2Jl?=
 =?utf-8?B?Y0NsTThxTUNtVmx1NHdBeDQwNk9VMVljd01MTlkrUndYRm92ajdRMzZzWGFR?=
 =?utf-8?B?S1dqSWtzTkI4QTExa3NiSE1aVW1BbU5EOXpmcysrMEZwWmVNcmtsOTRLaW00?=
 =?utf-8?B?c2VUbmhnc3NqWUpmNGFqeGI2U2t4cU0wRXIrWVUvYW9VSXQvZVR6bGdtVk1P?=
 =?utf-8?B?bEhOSDhWRjNLNFR0TVNINk1Uc05DRWNoRU9FblVjSkx5UlA3WSszMzZWYzJk?=
 =?utf-8?B?YXo5NW9HRUdIZlhjY1JqaTdSdTNCc1Y2Z09yVWl6SGxsamZqWTdOeFVyOVU5?=
 =?utf-8?B?NXY1WkhnQ2Z0ck14Q0NVWDVlTkpHTkcyck9Pa2lKVUYzbnZuelZTelhzTEpr?=
 =?utf-8?B?T3JYV1drK2d6NHJLYmd0ck5WVjRSVFhobXU4SmppYmlISjFYNy9HRk0xT2x4?=
 =?utf-8?B?MUpYQXQzM3B0SjJ5WEhxTEdRbUNnenlDQ3JJU0tMaUZJSVZib0puZ3pFbXJO?=
 =?utf-8?B?RUdRcVV1aVBuRndOZ1lEdGFBeTR1OFlrd1hzV1RVWktxeXFhYmQvWk51cS9E?=
 =?utf-8?B?b3ZIN1RMK3V4dGcySGIzZGZhblpmb21IcU5vU1dtanZQVVI1UUZGZ0dJZ3ND?=
 =?utf-8?B?WDBtOUlRbjU3WTlHTmRVbGg2N3lzcHFXSnZtVGV5MUxmM2RqSC93dGFDOUw2?=
 =?utf-8?B?TnppMEc1UTN6dWg1TnlGRkJCZ3hEYXEvUTYwZWtrMnY0KzVZcFBzcFNVcHJX?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <079FB269FAF7F349A37E2D327FC9B172@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6cbE1Atcb4n87Ae4bdMtsxuenkHR5hbt8wc2ptqsB81Fn+4Pf8wVvd5K1Tsny4jFVdyfpl2iWJJ4LN15gx6GxZ5N+n7KA7e12B8YflO1WoeEKxh8VKDHx5Mg+JippY1GmTJmPyICAyAipjv7IeS4jZy/6sOxon0IZ4wxmBLnJ75ggHJjduhKng/T9M8OWBN7zKOxIKF2h/COiJHGyq3LVowTtYcAD1PLDT5lct3kjGfVnwLQtmeCO4ej5IUP9bIZox0Z20By+p9H4H6nK2MzbPynCfkeJWgRWNrLYKo6rTrEuflapAMO7n0bafk7rjnoRevAVZde4OmMN6pa71MH8ZiqC7UsfxIAAPbGm2Rzv98Gshg9Dj2FItY9F/v2PcKZLEmKA4K/W8HTutRDlJBfTryrNrNlLc/StVTwVWmnrY0jdIGhwYz1m8XSx6UC0OHrnYLTxoQCm48bU4gnffBzday8SPeGTcdDuReXMzXvacsfzjMBB5fiMu7f4oPbZ9jxUKOFjcwvm0hMca0JQRF0Cnlx9LJSHEvjWoKX8RkvYQ90CwgNVosQz7NwgVcTiB+Sk7JJM/zK0EMUNMPZiO4aLCD3Am4zjF12mckOZVvr/Q9lW76fUgsAK4Fcx/ovahM/
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00674cf-c527-48ca-0754-08dd757c26be
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 02:30:24.2517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6lFmGv1FiOGP/RjP+TGfZ5QHY/M5Acc2qo2LMssQhFa8jZu+HfUVSi8yV61OW2FC94tEMHNN9XC3QCAgOpZf0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6572

DQoNCk9uIDA1LzA0LzIwMjUgMDY6MTksIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gWmhpamlhbiBM
aSAoRnVqaXRzdSkgd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDI3LzAzLzIwMjUgMjE6MzYsIERhbiBX
aWxsaWFtcyB3cm90ZToNCj4+PiBaaGlqaWFuIExpIChGdWppdHN1KSB3cm90ZToNCj4+Pj4NCj4+
Pj4NCj4+Pj4gT24gMjcvMDMvMjAyNSAxMTo0NCwgSXJhIFdlaW55IHdyb3RlOg0KPj4+Pj4gTGkg
WmhpamlhbiB3cm90ZToNCj4+Pj4+PiBQZXIgQ1hMIFNwZWMgcjMuMSBUYWJsZSA5LTIxLCBib3Ro
IENYTDEuMSBhbmQgQ1hMMi4wIGhhdmUgZGVmaW5lZCB0aGVpcg0KPj4+Pj4+IG93biBsZW5ndGgs
IHZlcmlmeSBpdCB0byBhdm9pZCBhbiBpbnZhbGlkIENIQlMNCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4g
SSB0aGluayB0aGlzIGxvb2tzIGZpbmUuICBCdXQgZGlkIGEgcGxhdGZvcm0gaGF2ZSBpc3N1ZXMg
d2l0aCB0aGlzPw0KPj4+Pg0KPj4+PiBOb3QgcmVhbGx5LCBhY3R1YWxseSwgSSBkaXNjb3ZlcmVk
IGl0IHdoaWxlIHJldmlld2luZyB0aGUgY29kZSBhbmQNCj4+Pj4gQ1hMIHNwZWNpZmljYXRpb24u
DQo+Pj4+DQo+Pj4+IEN1cnJlbnRseSwgdGhpcyBpc3N1ZSBhcmlzZXMgb25seSB3aGVuIEkgaW5q
ZWN0IGFuIGluY29ycmVjdCBsZW5ndGgNCj4+Pj4gdmlhIFFFTVUgZW52aXJvbm1lbnQuIE91ciBo
YXJkd2FyZSBkb2VzIG5vdCBleHBlcmllbmNlIHRoaXMgcHJvYmxlbS4NCj4+Pj4NCj4+Pj4NCj4+
Pj4+IERvZXMgdGhpcyBuZWVkIHRvIGJlIGJhY2twb3J0ZWQ/DQo+Pj4+IEkgcmVtYWluIG5ldXRy
YWwgOikNCj4+Pg0KPj4+IFdoYXQgZG9lcyB0aGUga2VybmVsIGRvIHdpdGggdGhpcyBpbnZhbGlk
IENIQlMgZnJvbSBRRU1VPyBJIHdvdWxkIGJlDQo+Pj4gaGFwcHkgdG8gbGV0IHdoYXRldmVyIGJh
ZCBlZmZlY3QgZnJvbSBpbmplY3RpbmcgYSBjb3JydXB0ZWQgQ0hCUyBqdXN0DQo+Pj4gaGFwcGVu
IGJlY2F1c2UgdGhlcmUgYXJlIHBsZW50eSBvZiB3YXlzIGZvciBRRU1VIHRvIGNvbmZ1c2UgdGhl
IGtlcm5lbA0KPj4+IGV2ZW4gaWYgdGhlIHRhYmxlIGxlbmd0aHMgYXJlIGNvcnJlY3QuDQo+Pj4N
Cj4+PiBVbmxlc3MgaXQgaGFzIHJlYWwgaW1wYWN0IEkgd291bGQgcmF0aGVyIG5vdCB0b3VjaCB0
aGUga2VybmVsIGZvciBldmVyeQ0KPj4+IHBvc3NpYmxlIHdheSB0aGF0IFFFTVUgY2FuIG1ha2Ug
YSBtaXN0YWtlLg0KPj4NCj4+DQo+Pg0KPj4gVGhhbmsgeW91IGZvciB0aGUgZmVlZGJhY2suDQo+
Pg0KPj4gSWYgeW91ciBlYXJsaWVyIGNvbW1lbnRzIHdlcmUgc3BlY2lmaWNhbGx5IGFib3V0ICoq
KmJhY2twb3J0aW5nKioqIHRoaXMgcGF0Y2gsDQo+PiBJIGFncmVlIHRoZXJlIG1pZ2h0IG5vdCBi
ZSBhbiB1cmdlbnQgbmVlZCBmb3IgdGhhdC4NCj4+DQo+PiBIb3dldmVyLCByZWdhcmRpbmcgdGhl
IGRpc2N1c3Npb24gb24gd2hldGhlciB0aGlzIHBhdGNoIHNob3VsZCBiZSBhY2NlcHRlZA0KPj4g
dXBzdHJlYW0sIFRCSCwgSSBiZWxpZXZlIGl0IGlzIG5lY2Vzc2FyeS4NCj4+DQo+PiAxLiBUaGUg
KipDWEwgU3BlY2lmaWNhdGlvbiAocjMuMSwgVGFibGUgOS0yMSkqKiBleHBsaWNpdGx5IGRlZmlu
ZXMgYGxlbmd0aGANCj4+IHJlcXVpcmVtZW50cyBmb3IgQ0hCUyBpbiBib3RoIENYTCAxLjEgYW5k
IENYTCAyLjAgY2FzZXMuIEZhaWxpbmcgdG8NCj4+IHZhbGlkYXRlIHRoaXMgZmllbGQgYWdhaW5z
dCB0aGUgc3BlYyByaXNrcyBtaXNpbnRlcnByZXRhdGlvbiBvZiBpbnZhbGlkDQo+PiBjb25maWd1
cmF0aW9ucy4NCj4gDQo+IFRoZSBwb2ludCBpcyB0aGF0IHRoZSBrZXJuZWwgaGFzIGdvdHRlbiBi
eSB3aXRob3V0IHRoaXMgY2hlY2sgYW5kIGRvZXMNCj4gbm90IG5lZWQgdG8gYmUgYWdncmVzc2l2
ZS4gQW55dGhpbmcgbW9yZSB0aGFuIHRoaXMgaHVuayBiZWxvdyBpcw0KPiBvdmVya2lsbDoNCg0K
DQpPaywgSSB3aWxsIHVwZGF0ZSBpdCBhcyB5b3VyIHN1Z2dlc3Rpb24uDQoNClRoYW5rcw0KWmhp
amlhbg0KDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvYWNwaS5jIGIvZHJpdmVycy9j
eGwvYWNwaS5jDQo+IGluZGV4IGNiMTQ4MjliYjliZS4uZmJjYjkzZTViZWI1IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2N4bC9hY3BpLmMNCj4gKysrIGIvZHJpdmVycy9jeGwvYWNwaS5jDQo+IEBA
IC00ODIsNiArNDgyLDEwIEBAIHN0YXRpYyBpbnQgY3hsX2dldF9jaGJzX2l0ZXIodW5pb24gYWNw
aV9zdWJ0YWJsZV9oZWFkZXJzICpoZWFkZXIsIHZvaWQgKmFyZywNCj4gICAgICAgICAgICAgIGNo
YnMtPmxlbmd0aCAhPSBDWExfUkNSQl9TSVpFKQ0KPiAgICAgICAgICAgICAgICAgIHJldHVybiAw
Ow0KPiAgIA0KPiArICAgICAgIGlmIChjaGJzLT5jeGxfdmVyc2lvbiA9PSBBQ1BJX0NFRFRfQ0hC
U19WRVJTSU9OX0NYTDIwICYmDQo+ICsgICAgICAgICAgIGNoYnMtPmxlbmd0aCAhPSBBQ1BJX0NF
RFRfQ0hCU19MRU5HVEhfQ1hMMjApDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gKw0K
PiAgICAgICAgICBpZiAoIWNoYnMtPmJhc2UpDQo+ICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7
DQo+ICAgDQo+PiAyLiBBcyBtZW50aW9uZWQgaW4gc2VjdGlvbiAqKjIuMTMuOCoqIG9mIHRoZSAq
Q1hMIE1lbW9yeSBEZXZpY2UgU29mdHdhcmUgR3VpZGUgKFJldiAxLjApKiwNCj4+IEl0J3MgcmVj
b21tZW5kZWQgdG8gdmVyaWZ5IHRoZSBDSEJTIGxlbmd0aC4NCj4+DQo+PiBXaGlsZSB0aGUgaW1t
ZWRpYXRlIGltcGFjdCBtaWdodCBiZSBsaW1pdGVkIHRvIGVkZ2UgY2FzZXMgKGUuZy4sIGluY29y
cmVjdCBRRU1VIGNvbmZpZ3VyYXRpb25zKSwNCj4+IHVwc3RyZWFtaW5nIHRoaXMgYWxpZ25zIHRo
ZSBrZXJuZWwgd2l0aCBzcGVjLW1hbmRhdGVkIGNoZWNrcyBhbmQgaW1wcm92ZXMNCj4+IHJvYnVz
dG5lc3MgZm9yIGZ1dHVyZSB1c2UgY2FzZXMuDQo+IA0KPiBXaGF0IHNldCBtZSBvZmYgd2FzIHRo
YXQgdGhpcyBwYXRjaCB3YXM6DQo+IA0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25z
KCspLCAxNiBkZWxldGlvbnMoLSkNCj4gDQo+IC4uLm1vdGl2YXRlZCBieSBhIGJ1Z2d5IFFFTVUg
Y29uZmlndXJhdGlvbiwgYW5kIHRoYXQgdGhlIGtlcm5lbCBoYXMgYmVlbg0KPiBmaW5lIHRvIG5v
dCBjYXJyeSBzZWxmLWRlZmVuc2UgYWdhaW5zdCBmb3IgeWVhcnMuIFNvIHRoZSBjaGVjayBoYXMN
Cj4gbGl0ZXJhbGx5IG5vdCBtYXR0ZXJlZCBpbiBwcmFjdGljZSBmb3IgYSBsb25nIHRpbWUuPiAN
Cj4gSSB0aGluayBpdCBpcyBvayB0byBkbyB0aGF0IG1pbmltYWwgdmFsaWRhdGlvbiBJIHN1Z2dl
c3QgYWJvdmUgdG8gcGFpcg0KPiB3aXRoIHRoZSB2MS4xIGxlbmd0aCBjaGVjaywgYnV0IGluIGdl
bmVyYWwgdGhlcmUgYXJlIG1vcmUgd2F5cyB0aGFuIHRoZQ0KPiBsZW5ndGggdG8gcHJvZHVjZSBh
IGJyb2tlbiBDSEJTIGFuZCBJIGRvIG5vdCB3YW50IHRvIGVuY291cmFnZSBhDQo+IGN4bF9jaGJz
X3ZlcmlmeSgpIGFwcHJvYWNoIHRvIGdhdGhlciBtb3JlIGFuZCBtb3JlIHRoZW9yZXRpY2FsIGNo
ZWNrcw0KPiB1bmxlc3MgYW5kIHVudGlsIHdlIHN0YXJ0IHNlZWluZyB0aGVzZSBxdWlya3MgaW1w
YWN0aW5nIHRoZSBrZXJuZWwgaW4NCj4gcHJvZHVjdGlvbiB1c2UgY2FzZXMuIEJ1Z2d5IFFFTVUg
aXMgbm90IGEgc3VpdGFibGUganVzdGlmaWNhdGlvbiBmb3INCj4gY29kZSByZWZhY3RvcmluZy4N
Cg==
