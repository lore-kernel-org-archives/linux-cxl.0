Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAAC18A6A5
	for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 01:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745889146; cv=fail; b=azbBmI2k3s5l7+agibPDyhyxBirvjhIIx46InBVO+TXZtsbQuaFVQTrmQXRX6uASKgea/eZyFOIpkAt2V8b4C2doJ8IVTFB6Xgem1IWbIKIklhbNFyJvFOYrreAtcNq7BnGmhoP6r5AwZzcE9nj0w0YnFPyYd4xZT4nAtvrC3og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745889146; c=relaxed/simple;
	bh=WvaC1ZTuZ4t9fWcniOWagt3EHAJBSJ2hnG8EWcmBS20=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TMFW0+OuCi2n8R1z9DsIbGQnHOY34E+DxjbQDgQv+BDpEZEDrUQqoXVkg+UiTm891IFP3qtUw75s4QYy07CB3WW0lu+aGPqpP0R2KonUfpIP1b+gWfqRbeqBwiJKsO6y6KBfsL9eH9kjBf9XAcLriwoqpvkZAPe2RJals8Y8PqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=udTv3YEd; arc=fail smtp.client-ip=68.232.156.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="udTv3YEd"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1745889143; x=1777425143;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WvaC1ZTuZ4t9fWcniOWagt3EHAJBSJ2hnG8EWcmBS20=;
  b=udTv3YEdg7jliX5eHhAu8QAf9X0rdgkLrCEGxnZqovQCt0Y4Zjzh40Os
   UtNKM1bdWupeFzg2w/hx2iUend6rPibY7cRkHXon9bYnCm3C6ZOeI30uh
   F4twW88wIpK/XmDeG0NPz1Qn97tDY4IsyuBl2+lFg7v2Ja09fAmIHbjhL
   RJFRr3kg4jCP5l+que/CzzqLkqVsNG/rs8oEIlMn792Vuye+RUyoRIl9D
   UPy7dcFls0CVMzYiXRYOQjadk1iReKEoTkl0jVy58ENL+Tzhm1PdoguSU
   kLhFtxiUqR5RGuxbSlrFtVKEwM7Zpy2GBEx9H9PfdzNjC/DEzday0wN5G
   Q==;
X-CSE-ConnectionGUID: jr0O2UmcShu3oZ1Vuov/GA==
X-CSE-MsgGUID: RwNI3uP5SDe7pwb1NAx4QQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="154636003"
X-IronPort-AV: E=Sophos;i="6.15,247,1739804400"; 
   d="scan'208";a="154636003"
Received: from mail-japanwestazlp17010007.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.7])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 10:11:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2vCfalCgbcAavFk7zR4GIdgIHLMv87ZJHlTQBXjsXrKCTN53gXYKofltReO/z5VH2+Amx8E2tiBugbV7wxGfv0K64vehSROKth+bciOjJVb+kzX3MwD7eFxjHLcjZVDrQ6e8zTCkItF/8WskqeIA8+FmNaZXpqD1fephLP9+Y+CVJVh65UYTtOcBJrdDWfnEiFDfybwL7oCVLHzcxAdhWNiuB1WlhJqwudIPJru9NmwnnZVdEQcOBTp9BIyLwI462TOyVwIg/apdCcWUubINkL/yjpnBuRrd5e14Hci+13MJjQq7WfH+ZMbCqIEhkiAShJ+thBdqwIqhANmTV0h7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvaC1ZTuZ4t9fWcniOWagt3EHAJBSJ2hnG8EWcmBS20=;
 b=g16BpNPmS4ceBiba2t2dIi4nlaGnd9TV0fJehND0I/FZh7LIQu7zY/wxT3K12SdS3xYunDUKddgLePZt4tXvR64/qxvKLlLLJgHJPffVsOPynst+eL8F+cK58VGG81jTRa9Zj2de9hOc8lHYvAGGASDVgKWvtJ9jeBuuhKryI/qu6tD0ZNHPWvFaUkQFCLATiIy2siqRtmPeW1BL1fnQzg/os3kfElqm/PpzWuCWaPTwgCHOHphyXcDV+4L4EH3DeuwdB/IUbyDa1RWwp75PNwTzNOrA79LBavMtKoRL/1toNusDpxzSVQZI26QsFkFDdqbI11dibQw2USDyF9UqpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB6915.jpnprd01.prod.outlook.com (2603:1096:400:ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Tue, 29 Apr
 2025 01:11:03 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8678.027; Tue, 29 Apr 2025
 01:11:02 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fan Ni
	<fan.ni@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] hw/pci-bridge/pci_expander_bridge: Fix HDM passthrough
 condition
Thread-Topic: [PATCH] hw/pci-bridge/pci_expander_bridge: Fix HDM passthrough
 condition
Thread-Index: AQHbm8o0B9htuAj4zE2+ObG4bZ08ZbOXmoiAgA15+4CAFPsKgA==
Date: Tue, 29 Apr 2025 01:11:01 +0000
Message-ID: <06c02571-8abc-4304-81e3-9413c47a0bf4@fujitsu.com>
References: <20250323080420.935930-1-lizhijian@fujitsu.com>
 <e2933a3b-7600-4f84-bfa9-d7b59dafb939@fujitsu.com>
 <20250415174717.00001509@huawei.com>
In-Reply-To: <20250415174717.00001509@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB6915:EE_
x-ms-office365-filtering-correlation-id: 19a0b34d-1d0e-4152-ca7a-08dd86bab53b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ek91UXQ2TXRVUmJnZWlaR2h6SE9udG4wdlljbE5VOHZNdU5VemxEVWM5SjZO?=
 =?utf-8?B?aXEzdzNRdUgvYVhFMGJ6SlJzNE4rbFJPRmJQK2lzMXBpRm5Xbm5IRnlVR0Ew?=
 =?utf-8?B?MmZ3MnZyMlBvZWpDTzdIbmFpNzAxNjdZaEp4OTBxL3RScGY4SFFrM20vOG1G?=
 =?utf-8?B?dDRZR1c2c21KSHZMeklHNXVXMmtQcjVSazB1V3RlcTZTQm1DMno0NmxPM0Zq?=
 =?utf-8?B?VGFKK2NibkJGRiswQVBuZ093T3I3azU1Ri90UWxISFZwbUxjby82RWJJNk8r?=
 =?utf-8?B?cFhjSTA4d3h5TE1oeHlaV3ZJN2xrcmZ6eEYrRklFK2xMWGlnRFBlbDBqc1Fq?=
 =?utf-8?B?WUxOMDRpQmYrSDM3Q0wyMGFGYllYZkVpbmxuSWRuUWU2Y1c5OEVMZ2xiZzFz?=
 =?utf-8?B?N0ZMWG5lenBLWmlPUEM4TldaNm1meTlQVXN3ZEpNLy9zUDhlb2VMb2VrRDRL?=
 =?utf-8?B?NkR4dWpJYVkyWHk0SktSM052QU9yWFpiZG5IVlorVzlQWUMzZEQrcE5adSto?=
 =?utf-8?B?QUY0akxOMFBXNmJjaVlnUGM3S3dQVWp2Z29ZWmhaOGxoL1JiWXI4Qm16bEFz?=
 =?utf-8?B?aWNMYS8xS044a2pYWWRYOXBJcGNya3I5NkNUcWVwN1dYVFJyUHBybytDRklP?=
 =?utf-8?B?UHBoeElZaStWRmtRYVd6dDIrbGpBbGptMDVNaWFOcG9RVHJDTG5LRFJ1SEdB?=
 =?utf-8?B?UjRMTnhGM0g2elRoUmZvUTZlRXlMNWVvZHNpb1ViMlhOb01tYnFMenViN2tO?=
 =?utf-8?B?QWl4akFwbzFtbFgyeHFrWDgwcndMdHNCbWRhcUhGdG1tNEM0Y1hVZ0J3ek1B?=
 =?utf-8?B?VzBpUjZBdXpDNWZMeUxxaHUrN2VyZHFyVm1mdmYrYXR2MDJiTTBMeXlOSzhO?=
 =?utf-8?B?NG84Y3B5ODBFaFJrSXBwYmtCMlY4UDZZVDRuTHd1aHNpdS8xaGJJcGFyNlI1?=
 =?utf-8?B?cUw1MjhTWVBxSUNPV1ZwaGtEUHVJUXpKL2VZNUJ6RzlnRzZ4QkZhbmgvUEZM?=
 =?utf-8?B?NlN6RC9wb2ZqaHlzK25QdHJ4bVY4bDU4c2ducFpMOFYyZVBtUzRRNm1odlZv?=
 =?utf-8?B?dzJvWTQ4THVHZGQydDdMY1EvRHpVQTdsQkkxVENkVnFXcHB5TEgyVzNWV2JZ?=
 =?utf-8?B?bDAyL2gvblhHbG12Umg1c01mTDJyMlpmdHVNa1FLUzdGYkltNXBDVEZScURo?=
 =?utf-8?B?czdzd1VMWVAvMnlrbkxvL2kyWG1hN0JPM2VLbThSOGFGaWZKZlIrUWRVZW81?=
 =?utf-8?B?U2lWNnR4eGM4WSt6WmVwNGszb0JYb3dDNm1aR3hIekIwVmNoWm5ubFNlandS?=
 =?utf-8?B?R1VZd2RhNVJaRTVwdG0waVF0T3ZCMzlsR1IrOGtIcDlSalhoN3RvYUkrU0xv?=
 =?utf-8?B?c2ZxWURZK1EydVVOaG9pc2hiK1pCYzFBcUF5bm1MUko0K2pGRU9MQUlQTjNL?=
 =?utf-8?B?d3NaWWlqeE1LMjZUSEplaEpxdG5qc2dkbktKaTBlRTJjRlpIQ2NvN3NueDVG?=
 =?utf-8?B?S000RmV5d3dUVDNoK2htK2tvWVV6QUZ5Q0hUeThNOHF3bGV6ZWdvQW9mbVpr?=
 =?utf-8?B?WnhEVnhzaFh5RE5vQU9IUVZHajhvVmVnaUdxRWVSSi9FQzNWcHlpb1AxWXYy?=
 =?utf-8?B?K0dRdFE2OEI5S09ZM203SlNacThKYTJpYTdLUHFnc2lrZGxVNlhtQm96a0Z5?=
 =?utf-8?B?MHBwUkE0WmloQTJhL2w1NDN6SDZWMHAreWhEN0JRZTZkRlo1aVJsWmZ1V2pE?=
 =?utf-8?B?Yld3N0QzNUFJRUpkUnVJT284N212NUFsa3g1RGo1cWoxL3VxSlJpTHZkRXA2?=
 =?utf-8?B?WHBHL3d5bDlhdldXbFphNS9sMjRLaFV6Tm9VUDhVa3V6YVZNdUlyY1hxT1Ez?=
 =?utf-8?B?OHJqa2ZKZldnZmtBZ3ZMQ2tZbTM2ang4b0lCdjF6ZVpxOFBHcm54ZWlyYlps?=
 =?utf-8?B?dCtSTFdjdSswcEhoTTdiemJrUTdLWGlNZDBKUUFVRkZSc0d5OWhtTFVRYzJI?=
 =?utf-8?B?ZFpPaGRFZ2lvTXFKbjZlMkg4MlN0TlRXdURNQm1MSGR5ZEhiUWIxU1M2dUZo?=
 =?utf-8?Q?X/gRgr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L1VWK2dZL1FTYVBua3FhTC9jckdzTHR3Z3ptcTR1Sm44dG9GbkdERmVGRWdX?=
 =?utf-8?B?ZFR6RERnRFN5RGxha0FOb3Y5SG45NlRCMDdYZVVveU82SGxremdEcUYrcTB1?=
 =?utf-8?B?TDZmUjFzUjZFMXZhcDFLeGVFTlpIVWJMV014Y2laVk9nMVZvZ1dvYlduejJB?=
 =?utf-8?B?UE1CSDZ2Y2lKVlF2UVYyWUNUWEZxTG1Hclg5ZUdUeDh2MjB3VWxUR0JUM0Yr?=
 =?utf-8?B?WGo3ZHEyeEI5Vy9zZ0Eyb0Rpd3A3RHJWK1lEbVFxaGpxNTdvWjJlK2Z5S0Fu?=
 =?utf-8?B?bGc2dEpwanZoT25GdUpERnVQYXRROS9NQTM2dFUyM0VtTE0vWm9LVlZNVVNH?=
 =?utf-8?B?ZS9uSnNyUlpWcTY3RVp0a3FqSXhGK1Ezc2RHZkFMN2FsTWtvbWVQS3gyYy9r?=
 =?utf-8?B?Z2VPeU5uampDOW9JdWk3dzdNSkdweXN1QXJmY0N4a2ZBTittakwyd3JPcXls?=
 =?utf-8?B?WVBGRHVOWElkRldYWVVqN2ZZYWswcGdFSG5qZ3k0eitOUDdqSjlCQ1ZRYnRx?=
 =?utf-8?B?VkU0czIyQW55dCs3bUtuZXA3T1lnSWdnUHR6Nm9kNlV1dE90Q2J0SDQ4V2hn?=
 =?utf-8?B?Q254SE1XV0VzaG9haEZrMytKeEo2em5yZnB6YUJHRlgwZFV5U2ZWbWZRNGNh?=
 =?utf-8?B?enVoMGhLN2dLc0M3dXlxbnY2R1dSY1FzOFlVRFpSSnVlK0FNQ3NYTnlYbmVK?=
 =?utf-8?B?b1NkTXhrV0hmWU55ZmRveFJReVpBSU5LVjJqZTcrMWtKeVpNQ2QyK2psVTlk?=
 =?utf-8?B?RHVndVYzcXpCdjNudmRkZmZFYkdaMlpQZVNtZjExd0xmVmtzT1U3dkxaZUVo?=
 =?utf-8?B?UTVLK0kyLzd1NTZobDFqMFpQaFBTQm8vd1EwdnJ6b0VFUHJnd1QvWjZXdCtW?=
 =?utf-8?B?c1RhQnBLQ0NhSHZDaXQ5QzJUL1RqQUNRUy8xRThnMDRQRXovWnFOZFphUHhM?=
 =?utf-8?B?Y1h5QWs0dGRCYlcwLzk4YkZkdWVoNVl6QVJYeVpDNnlJUUlrUzdNdThDRVZy?=
 =?utf-8?B?VW9tbDNJRmhaMUNSSnNtTlJxK2N3YWUyeDk3cDhxM0F3elBTWm52Sm16dWVY?=
 =?utf-8?B?MzZrT05NcFgwdGs0OHByOHZVY0d4TDY2S1VDNTRJdEkxWXZYMUR0TzVXTU5U?=
 =?utf-8?B?UEMyM0pYYXN5REJpTE9jRDgyWTlNR3dMZ0srSDNpSDdEQVZaclE1cEV4ZjBY?=
 =?utf-8?B?SE5XV3lRM2ZBeTdhYXhBaDNJYTgxeGoxRCtiTHpsR2hmUVZmZXljeTY4bWh2?=
 =?utf-8?B?VzBrSGYzcUNvV0dSejZTek1peTc1MWJFSWE2THphNTNvNUJZTXFUZHRsa0hB?=
 =?utf-8?B?a0VKWGtBUXRNMWY1TXdoS3paUWdVTHY0NExDY2MzRUNQMHJEMTdWMDFrVDBm?=
 =?utf-8?B?THZVSUFvbzdXd1R4b2NHcjBaaU5TWU8wUEtWV2tjRENQVHpLLzBaZTdUbWZV?=
 =?utf-8?B?YUJJY2swRE1Qc2dYeFNRa1hScE0zS09SUExwZTd1cC9uSlV3NjJyQnlTSm9x?=
 =?utf-8?B?M2FLYlhCbmpLOTJUTjdUc2tTeTAwaFQ0TzRudU9RWklqNEEvajQ0dm9XTGJM?=
 =?utf-8?B?OVhzb21TOFdRMXZkODhrNUpuMzFoVWF3clBQM2FRd3V1b0tXOXhyUi9LL0tV?=
 =?utf-8?B?K3ByKzR4MWQ4dSs1UDJCVlVKTHc0QmllWTh1WEZQQ2Q2MHVGVFFYVmFETmQ3?=
 =?utf-8?B?NzNnVVhUd21GOTRBWk52RmlNeit5Rkx2eHJ6OXdWUmRCelRsWlZzWHoxa01y?=
 =?utf-8?B?bXBaajFMTmdEOWEyVEdDTDZvNnNORWczL0Exd1h3a3FjbXFsSC9oZThBcytw?=
 =?utf-8?B?d29URmRrWStXTUtIbTNDTzFnYnlQOFpwZGREcm5ROVBhelJ6Sm1xb2ZYY3Ft?=
 =?utf-8?B?QldkN2lTWTg1QlN5WWYzWDM5NWxpSkMxZEphb2JaNnRUSWlQVlMyV2kyczNI?=
 =?utf-8?B?VW5IWkZlOG12eG9CTHVySEVjSjdocVVyMzJFWFFsQjdlWWNSZVVLVTk2UHcy?=
 =?utf-8?B?Q1dKRkZLcWxSMExPWHZWTE90WGhYdjQ2NExmTTAzSS96czltenFtaGxDZ1ZD?=
 =?utf-8?B?QjlOZE5RQk5YOVhxbjlsVk5PR0hsdmNSRTFFQjkzeGV6VmZkRUVsMmFRVisx?=
 =?utf-8?B?RlRCNGZKamdtZ25LWGJ1NTFqemJNMDc2ZkN0V2thS255dWtDczVaRXQzSmlr?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECD92C9FE7989248B7DFE448ACE25801@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N/oOBidl4jDPmMZvBZI2LdVqNrc1wZzFSQu+AkVRw9ijwRTHQDRLq5SFKbjD9kGlzcCmNLhUqSPc7MzFAJbtbAPy7qa5dMFwjp0OErDOiqyDnSkLyx9wODdo1EgQW68q2ftbGn1RGw0nBQXSbGmfVfimAZltLRZwvOmfrPgNZflYtBPGD6nXMyCiniIxdUSbriJSWzPiHcFE6+fTinm7sAQe3nRtD88l1b8Pbw/W8PkFbq8tg5Vu4xZd4N0zjAm8xWCoxaJjuH6n8KFXkQ64he+r43GLF0sQEdSy4gHfsSVn8HAUX9F6SDXBINHThUOj52ygSRN05WlfUV/PaNRSulOVEjqhhPF+WTSDeW/+F2m4Gb2rEA2hw2OlDs5dsvKFg1nbxEbDCuLIlG4GzW6lVAckf6mTr7pQhdQABXgmXxN44eA7tp7Y/qQHBFXTU5FamO4GTgzMWYcs76yhcQ+peD0wT9SxrqBieXNceQDDohl9z2bZKAcBHUKm7+OGnfiy0Baihv15UDjVCL0NCEiOzExqa0hBOmNzs7hHAK0mBfAAYrzkNOftSOGGMJHYMuBlQwJQlU1BVXMPNc1WPucYaQLJLUmMJ0eAw3+axYgojUAbdQ8KGV5q8psbq6wFgo8O
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a0b34d-1d0e-4152-ca7a-08dd86bab53b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 01:11:01.8836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1OdfSwpD7KAGz3YevQFNYnbZ0+nITKuyxk/4JiwCFfhUftj9rkloSP8iO5PcalCXoAhGJqGpqUmomHSwI5WVlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6915

SGkgSm9uYXRoYW4sDQoNCg0KSSBhcG9sb2dpemUgZm9yIHRoZSBkZWxheWVkIHJlc3BvbnNlOyBJ
IGhhdmUganVzdCByZXR1cm5lZCBmcm9tIHZhY2F0aW9uLg0KDQoNCk9uIDE2LzA0LzIwMjUgMDA6
NDcsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+IE9uIE1vbiwgNyBBcHIgMjAyNSAwMjo1OToy
MCArMDAwMA0KPiAiWmhpamlhbiBMaSAoRnVqaXRzdSkiIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+
IHdyb3RlOg0KPiANCj4+IFBpbmcNCj4gDQo+IFNvcnJ5LCBJIHdyb3RlIGhhbGYgYSByZXBseSBi
dXQgdGhlbiBsb3N0IGl0IGJlZm9yZSBzZW5kaW5nDQo+IC0gd2FzIHN0aWxsIGluIG15IGRyYWZ0
cyA6KA0KPiANCj4+DQo+PiBPbmx5IGlmIChkc3BfY291bnQ9PTEgJiYgaGRtX2Zvcl9wYXNzdGhy
b3VnaD09dHJ1ZSksIHRoZSBRRU1VIHNob3VsZG4ndCBpbXBsZW1lbnQNCj4+IHRoZSBIRE0gZGVj
b2RkZXIgZm9yIHRoZSBIb3N0LWJyaWRnZS4NCj4gDQo+IEhETSBmb3IgcGFzcyB0aHJvdWdoIG1l
YW5zIHRoYXQgd2UgZG8gaGF2ZSBkZWNvZGVycyBldmVuIGZvciBwYXNzIHRocm91Z2gNCj4gbm90
IHRoYXQgd2UgZG8gbm90LiAgVGhlIG5hbWUgY291bGQgYmUgYmV0dGVyIGFuZCB0aGUgY29kZSBm
bG93DQo+IHBlcmhhcHMgc2ltcGxlci4NCg0KSSBnb3QgeW91LCBJIGRpZCBhZG1pdCB0aGF0IEkg
bWlzdW5kZXJzdG9vZCBpdCBiZWZvcmUuDQp0aGUgd29yZCAqaGRtKiBpbiBoZG1fZm9yX3Bhc3N0
aHJvdWdoIG1lYW5zICJIb3N0LW1hbmFnZWQgRGV2aWNlIE1lbW9yeSIgd2hpY2ggd2FzIG1pc3Np
bmcgKkRlY29kZXJzKg0KU28gaXQgdGhvdWdoIG9mIGl0IHdhcyBhbiBvcHRpb24gdG8gZW5hYmxl
IHRoZSBwYXNzIHRocm91Z2ggZmVhdHVyZQ0KDQpQZXIgQ1hMIFNQRUMgIjguMi40LjIwIENYTCBI
RE0gRGVjb2RlciBDYXBhYmlsaXR5IFN0cnVjdHVyZSIsDQpJIHJlYWQgaXQgYXMgInplcm8gY2Fw
YWJpbGl0eSBzdHJ1Y3R1cmUgaW5zdGFuY2UgaXMgb3B0aW9uYWwsIHNvIGl0IHNob3VsZCBkaXNh
YmxlIGJ5IGRlZmF1bHQiLA0Kd2hpbGUgdGhlIFFFTVUgaW1wbGVtZW50ZWQgaXQgYXMgZW5hYmxl
ZCBieSBkZWZhdWx0Lg0KDQpUaGlzIGFubm95ZWQgbWUgd2hlbiBJIHRyaWVkIHRvIGltcGxlbWVu
dCBwcm92aXNpb25pbmcgSERNIGRlY29kZXJzKHRoZSBndWVzdCB3aWxsIGNvbnN0cnVjdA0KQ1hM
IHJlZ2lvbiBieSB0aGVtKSBpbiBRRU1VLg0KDQpUaGFua3MNClpoaWppYW4NCg0KDQo+IA0KPj4N
Cj4+IEJ1dCBwcmV2aW91cyBjb2RlIGRpZG4ndCBmb2xsb3cgdGhpcy4NCj4gDQo+PiBUaGFua3MN
Cj4+IFpoaWppYW4NCj4+DQo+PiBPbiAyMy8wMy8yMDI1IDE2OjA0LCBMaSBaaGlqaWFuIHdyb3Rl
Og0KPj4+IFJldmVyc2UgdGhlIGxvZ2ljYWwgY29uZGl0aW9uIGZvciBIRE0gcGFzc3Rocm91Z2gg
c3VwcG9ydCBpbg0KPj4+IHBjaV9leHBhbmRlcl9icmlkZ2UuIFRoaXMgcGF0Y2ggZW5zdXJlcyB0
aGUgSERNIHBhc3N0aHJvdWdoIGNvbmRpdGlvbg0KPj4+IGlzIGV2YWx1YXRlZCBvbmx5IHdoZW4g
aGRtX2Zvcl9wYXNzdGhyb3VnaCBpcyBzZXQgdG8gdHJ1ZSwgYWxpZ25pbmcNCj4+PiBiZWhhdmlv
ciB3aXRoIGludGVuZGVkIHNlbWFudGljcyBhbmQgY29tbWVudHMuDQo+Pj4NCj4+PiBTaWduZWQt
b2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+Pj4gLS0tDQo+Pj4N
Cj4+PiBUaGlzIGNoYW5nZSBjb3JyZWN0cyB3aGF0IGFwcGVhcnMgdG8gYmUgYSBwcmV2aW91cyBt
aXN0YWtlIGluIGxvZ2ljDQo+Pj4gcmVnYXJkaW5nIEhETSBwYXNzdGhyb3VnaCBjb25kaXRpb25z
Lg0KPj4+IC0tLQ0KPj4+ICAgIGh3L3BjaS1icmlkZ2UvcGNpX2V4cGFuZGVyX2JyaWRnZS5jIHwg
MiArLQ0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2h3L3BjaS1icmlkZ2UvcGNpX2V4cGFuZGVyX2JyaWRn
ZS5jIGIvaHcvcGNpLWJyaWRnZS9wY2lfZXhwYW5kZXJfYnJpZGdlLmMNCj4+PiBpbmRleCAzMzk2
YWI0YmRkLi4yNWY4OTIyZDc2IDEwMDY0NA0KPj4+IC0tLSBhL2h3L3BjaS1icmlkZ2UvcGNpX2V4
cGFuZGVyX2JyaWRnZS5jDQo+Pj4gKysrIGIvaHcvcGNpLWJyaWRnZS9wY2lfZXhwYW5kZXJfYnJp
ZGdlLmMNCj4+PiBAQCAtMzA3LDcgKzMwNyw3IEBAIHN0YXRpYyB2b2lkIHB4Yl9jeGxfZGV2X3Jl
c2V0KERldmljZVN0YXRlICpkZXYpDQo+Pj4gICAgICAgICAqIFRoZSBDWEwgc3BlY2lmaWNhdGlv
biBhbGxvd3MgZm9yIGhvc3QgYnJpZGdlcyB3aXRoIG5vIEhETSBkZWNvZGVycw0KPj4+ICAgICAg
ICAgKiBpZiB0aGV5IG9ubHkgaGF2ZSBhIHNpbmdsZSByb290IHBvcnQuDQo+Pj4gICAgICAgICAq
Lw0KPj4+IC0gICAgaWYgKCFQWEJfQ1hMX0RFVihkZXYpLT5oZG1fZm9yX3Bhc3N0aHJvdWdoKSB7
DQo+IA0KPiBUaGlzIG1ha2VzIHVzIG9ubHkgY2hlY2sgdGhlIG51bWJlciBvZiBwb3J0cyBpZiB3
ZSBhcmUgbm90DQo+IHByb3ZpZGluZyBoZG0gZGVjb2RlcnMgZm9yIHBhc3N0aHJvdWdoIHBvcnRz
Lg0KPiANCj4gSWYgd2UgYXJlIHByb3ZpZGluZyBIRE0gRGVjb2RlcnMgYW55d2F5IHdlIGRvbid0
IGNhcmUgaG93IG1hbnkNCj4gcG9ydHMgdGhlcmUgYXJlIHNvIHRoZSAwIHZhbHVlIGlzIGZpbmUu
DQo+IA0KPj4+ICsgICAgaWYgKFBYQl9DWExfREVWKGRldiktPmhkbV9mb3JfcGFzc3Rocm91Z2gp
IHsNCj4+PiAgICAgICAgICAgIGRzcF9jb3VudCA9IHBjaWVfY291bnRfZHNfcG9ydHMoaGItPmJ1
cyk7DQo+Pj4gICAgICAgIH0NCj4+PiAgICAgICAgLyogSW5pdGlhbCByZXNldCB3aWxsIGhhdmUg
MCBkc3Agc28gd2FpdCB1bnRpbCA+IDAgKg0KPiA=
