Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7504834A3DB;
	Thu, 12 Mar 2026 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344585; cv=fail; b=KzfeYhjVFIXoesWS9E7JTV+aa8WC1kz+g8wt2mLgwb2mWH751cVcOEsT+aEmC8f9PtKSm++WbI5Jl1Vvl4HW4X6HlxSWVrnrFtjV4yTpfr3+JmXSc7dAOoBRXDIgLi30+k1QKCZFs/9uNtZs/3RD4sZvRkQIbh4koI3oxW/hKGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344585; c=relaxed/simple;
	bh=e0rRqpSyljGFZlgzgjZebyfDecE0n8UPqT8VVrtTe58=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Oc3iwsIyK7+w38N4c2uIa1BUG7kLGduBHvPhG4d6nSIOe+wowycOqj5u+E7sr91I3X9LFEdrgmldCiwY+atZr5eunle1KUC7P5nBWUvgWXNTNwd0vaelO/wI3W+acQQwLcjl/IT5iZZrk5LcB+B0azRrpJvokjv36r2A27dowWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YIBdDdq4; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YIBdDdq4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773344584; x=1804880584;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=e0rRqpSyljGFZlgzgjZebyfDecE0n8UPqT8VVrtTe58=;
  b=YIBdDdq4DTaWTS7Oy+j6g4sRd6SYpiN7qZSdZwq4qWiHOo6fx8aGohvG
   gZuvC7Z3+CUh8l8mfsqhWUfYo1CHFOqA5RkCaJtwesXT23dKn4oje5AsT
   20MrCzhpZMFyXGFsQ5kZbuMWT2BLkYeACYcGAPw9bp6Vfn+SJiwTCGClJ
   KRHZ2LCC1V3x/dk+Wj4Wbj2g8kOkKUm8Ez5RFZ7ClJe4LooBKWhqgftI0
   LTEZwGR5QFwI+xyLS3MVBQrxcawRS3KS8t3+E78bDfhMW/oPHG85OW41r
   E8Cx9KCVhmZS3e0naWPwXNSFNXHmdXklGvGfTUOmOhSO8dNenboHsq9Uz
   w==;
X-CSE-ConnectionGUID: LsMyBWvlQSiCByUdwKwSWQ==
X-CSE-MsgGUID: 7OgnOvbDT/WPQaWQO4MBww==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="78300910"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="78300910"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 12:43:03 -0700
X-CSE-ConnectionGUID: 5VAWFUYGT6a4MMq43W7x2g==
X-CSE-MsgGUID: YVl9SEZERLWpn2vTYicJFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="220185511"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 12:43:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 12:43:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 12:43:02 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.27) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 12:43:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zr9XXJMLh//hNcVufmqmmdrL5ttBUgekOnyOuHtHBoRX1StBHVMZPwErqVK0M/cuOo31y5O1r3iKWYiD4bt7yAkrQRhcUAEgvDHRKQc4Lp+KzpS/nU8Ftivpa3D5SNSKC6EGqI/rKLV5G9CbmJtyt4PSucsXr5PFRZ4ifpsg/m2PSwdAgqEfK8R8jpFn9QjSkLT1CI02rMDENkKoENC6QkBKsWxf0y8JAj1ItWl0lZ+2WKvBrK651HagHnVlwFm4ZzoPyQnSHzOtzhzCC9Zc3VmVridMLIvcHEqlVEn0gIO7d4m8wpm6g5fu5MJFX6oZVqG2qrU/gMTpdCPaQjqwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9bgWAWBEq39z7fiQWYmURK01MdjuxU3mmSHXmtuZlg=;
 b=P/fb10u2qo0rn30B/POafVXCIZLFl2JUG2ySiJiisX4uiSllC4RNTtw+i9hw4XR8IflvF8Om9ZH5OBp2U3eAszRui64YzxeQMg6FJJ2n1b9T+iqF7jYYMR+pSUn5sVXJ0//mqQDOrFnnb53MeNfOeW2gV2PethAb/dqZ42HDhfDNTqELCiVaGTW6HiX63BEKCxohlbCYs/woN1q6XmP1TZN73szfY94u4+XE5WpNRRXXXL2CdWJlqUPOOnO+4W9VUaIJqp+fCe2aMSN2ZR7640QI7HNyF/0KbFx+gD9hwYd9tLyE5pC48spvQLJjyDxZCdsLYDHbk4lE3sYzY/ubgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7920.namprd11.prod.outlook.com (2603:10b6:208:3fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 19:42:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 19:42:59 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 12 Mar 2026 12:42:57 -0700
To: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Terry
 Bowman" <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>, "Benjamin
 Cheatham" <benjamin.cheatham@amd.com>
Message-ID: <69b31741a3945_21321008f@dwillia2-mobl4.notmuch>
In-Reply-To: <dd8e4ae0-94db-4c2e-ae92-6e01e07c626a@amd.com>
References: <20260212223800.23624-1-Smita.KoralahalliChannabasappa@amd.com>
 <69b0dff5b6043_2132100cd@dwillia2-mobl4.notmuch>
 <dd8e4ae0-94db-4c2e-ae92-6e01e07c626a@amd.com>
Subject: Re: [PATCH] cxl/hdm: Avoid DVSEC fallback after region teardown
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f3fcfe-f4b0-468a-819a-08de806f9092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Z2g8pnSOS71+J1XUV7PeQ8SsoP+G7mD5aet5tU2/7mrxaftWrX+BFnC9CaBNzplAwGpc7ovU0zjs9QAkU5gRI6Q0nLqTYycBOirLqJH5gEWuagXMuXvBIjK20mo7AH3jmEkygQ2tbaP1XCzApNlpjPniqztGOpm1Satk5Q2DoXQungOai4gmH66wEfXhmzKLt5Wu0ligu2US1/Wyrjum3Qb7UNRJxXmibkY6uyiUj4pEVvT/m60hx9KfaZCy26PPlyfouBobBHa8JFYrB2VYDW74apG90/2sMYZ62gisN+NkBnf1w0j0oWklTncX7LkA/YdKhw/LbmXwSqTmzmBtZM6u+acfsK0meNkE0YNzjc8KBTONScNZRDe9Yr0N2Mwl6A7FWUDMDbXYtQgJsWuyWXBJqifRzSBJ6IUgpIGa8JUYCZ/OskwZTl5h5uCvT50NAU/kY3kuqckcrAJ1b8zGIJ/FbYQ+Xog0wZ2rDTTbXkUjje22UaSYdCoL4NCX2WRnWYQvAHnnNd7jGrJ/ju/sIhn/EujVbag5Eb8qj0SuII4Ou39j9AgtqkAMD92whkooCnhyQApEBAM+svPqm9W97HpXgKpwGJTq7zuEHGWfi3KG6evxTFVd3pkYEk2hnwfyYZsS46p8Zf1dREKHxlGJckaW0FtH41UNMyaThHYUHrhTEmzenVRKqQPAJQsaMiBzBpztO//12cGi7fjqoxbsg2HBi6BJv0DCCBw68Yu+Yf4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3h3ZDNxWkhvWXNLSnBVMWlCd0tTbUpxQ1JEd1J2RVhxM1ZrVDNqcHQvaVhG?=
 =?utf-8?B?N21HcUgzaVc0TzhCOVQ4Q0hyVVVNRWFXY1ZNTnNwbjJTeDhnTDRjT1NKYWl2?=
 =?utf-8?B?ZjJDQlJSSHBHQ051alUwc2o4K1FNUndjL2N6cFpOQXVjK2JNcGh1eElsOUpN?=
 =?utf-8?B?amVrbExOYXFmSytKc1pxcWhWVjB1cUQ0Zlo3WUtvZTBsckFsNjE3YzVCTk9s?=
 =?utf-8?B?MmxkZS9UM1BtTnhVckF6OENZSTNzUHIyaktGMUdoRks3Z2E2NnIrb0VaRnBO?=
 =?utf-8?B?SmNDT014dUQ3NGRPblgzM3NmTHY2YTRFT1c4bmZWcVNkaEJVTW5VOHBWdUVz?=
 =?utf-8?B?eUhvR21QNlpxaHJwWXc4ZzgyY0lMbEJsTGV3RjZCRzJCSmUwc1dHTURDOHF0?=
 =?utf-8?B?UGJBU1V1VzdaclVUc2tvZGJEc2pkNUpYdVh4QmYxT2FnNXJpSm5NNG85UXhF?=
 =?utf-8?B?U3UwMDJReXU0T0pENlp3eDRtbEkxWHpjc3F0SU9OU1NqL3U2NWdCOGE4Nith?=
 =?utf-8?B?dzhqN2FNOXBPeUp0b0lwS21SbnpQcmNwRkFqaHJSNGFzOG55MXZ1VUVwcFda?=
 =?utf-8?B?N2tnampZMFVkUzM0aWk2UlFuaFVmZ0tzNWFwY00xMlBjN3BKdVlzZ0VMTHlG?=
 =?utf-8?B?c2VReU52STZSbjQxWld0K3lrVlNsL0dXOWRvRzhnbFg4cm9oTmlMV3dMODRN?=
 =?utf-8?B?N0thTHFwYmNTWDg4SmJNekRYQzRFa1VDWkFRZTIyVjAzSG5sbmpBV215QVdH?=
 =?utf-8?B?em9QNjMrZ0N6S2FzME9hZVdkYyt6dU8wT29NNnhGd1R2WE9NbXZ5d3VwRlFy?=
 =?utf-8?B?UkovdDB0Y1JPQ2RhaUxIYXR6MzhRZ3pmRUliZ01kVGR5dmM5VFkzTVEvbnI3?=
 =?utf-8?B?OGkxOFVZejNxUm5IR05yS09SYTJsWnAzdVhsTCtnSGRUcmdkL1lyRjdzQk55?=
 =?utf-8?B?cXNFSTM5Z3BkbWg1blBWT1FadWVmNU9NaU9xWkRuanFCWUlBOGxERVBPcUl1?=
 =?utf-8?B?QjhwaDcwS09RTGJleVB6amlEaW02d01HZStDMUlLY21sTjZWWVVpY1FYQW1W?=
 =?utf-8?B?UmhnWmx5NmFNL1BUSzZ0YWZMVFBJK1h0YkxNTkRoWVdsc2xQOEFYaDJRVjRE?=
 =?utf-8?B?MmlQemZaS0k3elZ0UFJQejVsb1doNTIweWowbjdXdktsdXpTRzF1bXlkd2dr?=
 =?utf-8?B?VzRXOGVSclF0d2JwcnFIUy9NN2J4d0NyWk5ESVlhenQ5V3JiNlVhS1JPcFNa?=
 =?utf-8?B?WWx2ZlpscXlrM0lYeHlhbGE4WHdzTlBIUEdac0V1bjhNR3F1czJTUm04MWFs?=
 =?utf-8?B?V0ltd0loL3JGM1lYQ2drbncrdnBKT2g4dHFPVG16OTJURk5KMkJ5d05VNXBy?=
 =?utf-8?B?ZjkrQThYcjgyb2FKRy90ZUp4NUo2ZWNpZloraUV3eWlUNDF5eUllQTUxbkhP?=
 =?utf-8?B?RmxBSU84aEJmYmdiazhuRTZBc0JoQ3RqOC84T0NkYlMrRCtNVjcycTNBakRO?=
 =?utf-8?B?bEtMaEVSM0YrSXZQbEovQkszbVl3L3ZPcTVlMXd0S1VKL01PNEJRdWlncnph?=
 =?utf-8?B?OHNSc3ZvV0hXSnI0cDNTdnFzZDR5UVNkdXBDaGcyeXd3WHM1S2Z5N2h4OG1H?=
 =?utf-8?B?L3NtTUVEMTQrU0toS0xGSlk1bUV2dGpvWmlqWnNkOXh5aVBIOEVZSVFwMkE2?=
 =?utf-8?B?eUZtaTBxYVNlcnduSnRzNWlUSW9sVFVFc0NoTU55Y3FvNkhDTzB6azJhYXdq?=
 =?utf-8?B?aXZEbFAvV3VSNWV2a2ZIdFltV0xFUnRobi84aUZub3Q0cFlIY053L09ROGpv?=
 =?utf-8?B?NDl5dVpnTHd1UWJRV3ZoUUljZFVUNnV3YlZwVkp5QWR3aURkNjZZUHphWkN3?=
 =?utf-8?B?cDZBc20rMTZyTUF2RVMrMjZjL25sRVhTV2NTOXBmWmpzUG5PbklHK0tNbGIx?=
 =?utf-8?B?WW5mS21rdzlHZTdIRzk4MitUbUZLMEZMdTVxVFV3dHpsSDR6ck1ic2YyS2xs?=
 =?utf-8?B?UlBScnN2N1g0TXA2VzFaZTZrSlhkemFHeFhyMFh6Nlh0WjRCUU1Dd1NMWENG?=
 =?utf-8?B?UHZBUzZ4T2RGM0IxMGprNnNCMVpGeXlUbGxsTUpUS3IxcjhITFI4amZkU0Rj?=
 =?utf-8?B?RFNxdUQzckFEUWd5WXg4cDBQaTliYzNFM2RyclZmNlFPdGdyRHoyVEZ4WjBO?=
 =?utf-8?B?UHBSTmFlNXVPYUpFUG1LY2hOSVZOdTgvN3M4UnpYLzVJOWpqdzYzQzB4SzhX?=
 =?utf-8?B?ZnVCNE5oV1ZOM2hkU3BEV0V5YjVEOFNWeXIxeUhJMkJkT2lud0c0VlhvQ2dn?=
 =?utf-8?B?aGZBNGpPMjdSNCtyZTc5Yzk0Z3dqRkxUR2svVUI3Kyt4NmVXQTFmdkdDTjhi?=
 =?utf-8?Q?VtoiiTVkagfmAYx0=3D?=
X-Exchange-RoutingPolicyChecked: QE6ty/FxQwLkuyDGspYNhPwhBBAHLd8ddo4SYGtoMqiB4XMm8/Ytvp4wji/W6KTr0APs/fyKag2SleetDhJfy3z+8Ak32cYpAx+40VcDyvIW9+NWmu/KXwmhOYiOFPLz4L76483gx885XLAvMi+LNKBdXFAanVr3nUOBE5VT36msfCwvzVew7ZCcVYF2SHIZZREaS36oGsvdt5/Q/7bI7nxJvq99P0mDIDHkt20sUAB6s+o36DppQqmDF9vVlFLff2eLxjKKAGZDfv8UaMa6jvCks4f7y61H7IE8/yCPb1nnIlNEg/fBgjg/TBhGUzoe2Q8q+Myf8RFsvFBST0ixvQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f3fcfe-f4b0-468a-819a-08de806f9092
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 19:42:59.0296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UEJg4LsrvlkBoAG6yXfxABDW9oJM5gsepL7vpv+poXPgF7M6R6CeHver15GsAN23xPXY/SW6yscZPDzZuOv/7nHZa+dwzE/FZuQ41mn95g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7920
X-OriginatorOrg: intel.com

Koralahalli Channabasappa, Smita wrote:
[..]
> > "do not teardown auto regions" should squash this crop of setup bugs.
> 
> Looking at this more closely for patch 2, if I'm not wrong, I think the 
> problem is that cxl_setup_hdm_decoder_from_dvsec() is not setting up the 
> interleave_granularity on the decoder. It inherits the default PAGE_SIZE 
> (4096) from cxl_decoder_init(), and construct_region() then copies that 
> stale value into the region params.
> 
> So even in a DVSEC emulation case, the IG would be whatever 
> cxl_decoder_init() defaulted to, not what the actual configuration is right?

Remember that CXL 1.1 DVSEC range registers do not support interleave.
Interleaving was a CXL 2.0 feature.

So in the case where HDM decoders are actually disabled and DVSEC Range
registers are sufficient, the bug is in cxl_port_setup_targets().
Specifically, when interleave_ways == 1 then interleave_granularity does
not matter. It is ok for CFMWS and the region granularity numbers to
mismatch in that case.

So I would not expect that ig mismatch matters after:

ce32b0c9c522 cxl: core/region - ignore interleave granularity when ways=1

...did that miss an additional location where we are doing granularity
checks?

> Is the second patch about fixing cxl_setup_hdm_decoder_from_dvsec() to 
> properly set the interleave granularity?

I would say just clean up the changelog per the feedback and we can
start a separate thread to fixup DVSEC support.

With the suggested changelog updates you can also add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
