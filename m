Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792439644;
	b=XMSDr+ourXOHtI+W4AP7H79i+RP/PmIRiIhcIBK9p6NaAQGi2P4d7ID+9zK/yyxCT7bg
	 kMlUYSFTCOBbecGr1fVRETgHxHx4SK1lOLaH8ZBz8thbx2jQkTV5fkfmfOPAqEBO0x9tj
	 Q1WXO9XQI9ENywkZW/VDrmwAgeh1tRjyVezQ4oGMm+g8ylKGrIJyp7h4fOt76/C1prSBN
	 Lzs82qO9kgoijo+iVCxqnVRoIEeDRoeHHBql0eyMr44x3vNTD2n6axyMwsoO6tkJ/F8lT
	 d7UrUAALqgBqH1mHW4ySEJj9hA63bDlhSTKlrbPiFzzaiW0YrlDbQgZNsmOmtzAom/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439644;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=1m6VwGvU2i9VkH2lxzW589AnGPUyCBiVKofI75V/BjI=;
	b=IqvCKjggPWv35Fcsvwddsh8L8CwOjth4uTls2uWaCjoTrW2JprABN3yEYUOzSjk5Z2xW
	 vzh3X9AuSGpGQO3WS/+HOYtdfe7h7rTKryYc22+jzvoDE8VTOoY61T9GGrWg52fvm/9Db
	 hi8MGXK1FXPDF0D/R46zPy3ysJfQFxGUfDDg8pKZUX9zWnQil8s6BxmyeZ4ifDoA1XXCX
	 GpHu21jIgL8fKBqc+X5KAv6KLzp9dpyVPw4qNx0xB0yTys7QaEm95DTti7xE+5ye8Z9fM
	 FkZ+q46KC1wi45oOtLqarAY6XM59uls2cwjxkXjIR7zRyRWRvuiEe3+e+o8G/Ozeiig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V9ARP30J;
	arc=fail smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EED0606A31B
	for <linux-cxl@vger.kernel.org>; Mon, 19 Oct 2026 19:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EED0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V9ARP30J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792439643; x=1823975643;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JZ8PtHWXsLDwBDPsO5XEVgkcKx1w9wjtN4E/HXR2JHU=;
  b=V9ARP30JnfAX12sgiTxFY2dFT6HbbPSNQ3zYqjJXGxTgFLVspzYBYUPy
   2Bay2NiySnOHRuyPxUPgugmxhld+vbS5/0BB9LulxJoGcSjOEUr+f88a5
   3t4vDggNKXnBzQ7xNT3Bm3yGtY2Ft1wC/KOCa2eyiyywwG34lILHUlQiS
   1cm/r6cteiqrKryPfPAJ3eBzx9X8dKZQNJOEu8TsVyu1Hqmqs3IZ4bith
   bGz5sOUc5cmWJUg3/tY74pxIavx0mGb9wLpb+DSLQmevU7qzWVLSFseES
   KDFYxvCbPpxuUIdzD+0cI9KXdOJfsv/bxvr1JA8MHluB2WTatntj008At
   g==;
X-CSE-ConnectionGUID: vh+MW7RNRIKUC3l0D180OQ==
X-CSE-MsgGUID: skDCd5M/RVO2BYardR2YGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1127418"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1127418"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 12:54:03 -0700
X-CSE-ConnectionGUID: +08MC7+bTqKNBmDv5vzu7A==
X-CSE-MsgGUID: 27rwBgkaRb6+Y5LJTf65iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2594713"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 12:54:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 12:54:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 12:54:02 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 12:54:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kigtUqRJ/kYvUc1BxwJMjXUbkgk4FEpsQqjd21Iay6+olYdMgIU3A3kltxhSIcZEy9l7h6R/9SIvIxsyPNHTG3Z7pSmbZFzAEeXxTGRQW9M0IiggDzRUx+VZHm0DIiAy0yuk53SRacL6UQYBJnHj97G3NoO4A7ktX0x7yKTnpMiDJMnKVF9AysP2A84EQ0MRW0CqWLIz5xPkM3K1kxi2T8GxrZH31PDuMT3keU09iH/vkRO7sbSw2M1zMo4+JA89Ckl7NPjKxus2yuZHnxlmB/3HopN2bSCl/cdhvJM47OyS7I0X16SBJzX0ugDrLaSV9JZ2CJuvidut6MNUmyYGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1m6VwGvU2i9VkH2lxzW589AnGPUyCBiVKofI75V/BjI=;
 b=B3qj0BErg4IR8vjGmZCctwZXVkyP+sSm8Jikl/lAB7T07CiDyLK58qbI9QxxToTkSLnrIBcGOvMu6AX3qB8016hiY/AKLtOhBnDatL9eTzLey0EWsar8RPk+jR3vpqqnMWLVbrLqbaVXgC0PI6dnLH+2oNXuVoijmiZya7isAe+VpTVySCTIaQFnqcyjtzOcyXQpXMOlGUH0McCsv9AzTkMhDS+QvXN/zJP0QA1SZFKPR+oHikH2VsFMg4rgFTWxyDTtR8TDkc7gGhv09gEtHBPlT0hozEyXJ/opF2nTIOgGtVg6YBKgsDty9CZWxhOrt10nq7fJJRWW3dmb/Q4G8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA3PR11MB831931.namprd11.prod.outlook.com (2603:10b6:806:589::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 19:54:00 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 19:54:00 +0000
Date: Mon, 19 Oct 2026 12:53:56 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 4/9] cxl/region: Calculate peer distance only for
 reused targets
Message-ID: <atZ1VABsLShhEPm4@aschofie-mobl2.lan>
References: <cover.1792263750.git.alison.schofield@intel.com>
 <6ac7f8fae75f7cd29b5d530a552aec2b6c6169b5.1792263750.git.alison.schofield@intel.com>
 <atXHAZIgcNlLURSx@MWDK4CY14F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <atXHAZIgcNlLURSx@MWDK4CY14F>
X-ClientProxiedBy: MW4PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:303:8f::16) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA3PR11MB831931:EE_
X-MS-Office365-Filtering-Correlation-Id: 50562ccd-c9cc-4e13-a0a7-08df2e1ab7dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wknQP6wXrC0WSNStnKCsAO8bC3P082k81/CTQr/wayaSLULoVR0cI9yHgVTiklyWuemfeuqsswAe3Hu92RN99cTZc+Llt1kZ8LwVyNuq2KAwMVFzGi6c+PlwFBXeXqxEB+TkWYbC+l9YPIamvbDOREv587OFO8EhpoKn0nBLdxE566PY3tjZvC59x6eyoRTmxaMmNIqPQ9JRrPMWt/IxfKbMStCwUEvImzzMf191WjDqufwkBzoyMw0EepHooh1k1A39c3/JVdOtGvvZggcvU+7Gwph3WYjB22jE3lSo6k8lWqseydW1tl9TqD7PmmHPtp6klBbemS+2RJ1zti6lKEfv+5a7kT87WzU0vajuvn9QmbLpkjDV9kfp4ZBVjUG7fNs5LxaZ3haL1U+8fQwtEEt9TjuJZ8vwLsah59PytT8qJJ9QPLsmOC35WgWRxq9rM5V6MmGoySK+rahNDsAdRxwZ8q4gIrnW/j/IGztc0VbhFVKGjq6rKvKv3HXDM250M9t3H+DTKSkuU4FIwdf+zBxsB4pGS6yn0ufhJ/+3SFFUhPNfSv71uZubnMJccpX592HeO4T+Ai6yRZ3U+q6H8v1rS7hO2WB/EX4dQrW7LsvXkweDQUnfIKNmhlhsTcw6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6DvTNLNL7J+QfAaoRjcOgZKMt1KiGfMD0ZctBnY1YSnEWWLEan8kAt3/KYij?=
 =?us-ascii?Q?wEOX2iFrnU0SzAjnrKYjgCXcpD5BUFSXHQgRTWHFDtY+Ydy1wwykLWthZpWt?=
 =?us-ascii?Q?ucfpZUpoQJzICOf5AeUO12Nf0+Hg+zhC857XWMKi5TuaczjDcHySggQ91efh?=
 =?us-ascii?Q?JWocZMYA6O6Qvk5Vlh2VM6lsfxP8PbTp/QWu/CJnYjgPzvEPupZab0sF+3/c?=
 =?us-ascii?Q?CUQR0DVj/TNWRj9u8dZ9ycYD9twte3apGAxBR9WBZ+8fSnOh49isIhn8N9AH?=
 =?us-ascii?Q?DxrYJsRRERNyiY57XG6NRloPLrgFmkB89SmLNVwJK7cJxhyQwuq/JsNsdJEI?=
 =?us-ascii?Q?1+5Wh7EyOk6yFqMcVLHmNFbSfgeY5zfqEAKRA0mghJHIfbKwiLnUa5AXNMLe?=
 =?us-ascii?Q?SmwmNl4H91cbvptx56L9uhmuzu5O2wcg8VcRIzVWDjFJla9qxmMOUA71cRba?=
 =?us-ascii?Q?TRlS12bQMY4S4h9Suox6zkbO6nirE0zTzn6K3gZ4pwDLtAdw8Y53EMsFXXDT?=
 =?us-ascii?Q?kS0InNZpnCwI4obag2bJrDe10mAhKGIJooF99Xxs+MhPDnYMjHU25/YV9x/e?=
 =?us-ascii?Q?24mD+UBiVLVa6qOLIm/fV+16RcCOYSGs6KTtPLJW/DGPPJPwIyrwYpfbK9vm?=
 =?us-ascii?Q?9SqXUWO5eLXpysvUDXxsI94V7ZO5Ud0+qaXWVHMLOhCYv6bfWLindTYl48oK?=
 =?us-ascii?Q?MWX3JWiR6ao3VbyjDhgZ0bbFuSOBRl/gbQQvHY1dJm7ewqTaxqmevw0cfuIZ?=
 =?us-ascii?Q?GiKAjjzWl9opcvyIZz+vNZRtp0KPdn9xOdCeZIadNnEVW5SImNzvVENzTKJs?=
 =?us-ascii?Q?LeLNTDtfJGeug2UQ7dhIsXlOFaJ7TnYCV08STfWRUdbZEg8F6x69hv1YPUBB?=
 =?us-ascii?Q?SL9crpHyZeOm+QGtNVsVJ8q0/B1ei7rsxfv3fEqKtZhY5qcmpG7DfGWwkvaq?=
 =?us-ascii?Q?zq9CCHsU4WiXb28jFv6E2avHCTj0MgrtG5QcPfofOPYDPOt6VxBV3xTxNOTM?=
 =?us-ascii?Q?9att09U0D8jhRtJ65evJdMXGBd3tq2EqMiVnagWFj/5EdIM4tGYPGmYihd/z?=
 =?us-ascii?Q?477tDfq06egBsSyWuNcjh8yw5TSQEeQ31RBrepjvjDDc7TctblwTa4g/OoP4?=
 =?us-ascii?Q?WAtb1kxpQHfzd+rtd1n+nBpDAZ27gTBiG75y9USDqJXxcHPLd/GUBLKmjLgw?=
 =?us-ascii?Q?OYrfX3Q5wfwNGs4txPCahxtjeccbq1kn2SBAyiSaj4vZwkSFENnad+1fijQa?=
 =?us-ascii?Q?MRZvqZmd34H4n+rI/kq3nHlUQ3NYoxUTlbMYoLfTVKdAHUh9lKfqA1vAdJhm?=
 =?us-ascii?Q?924NndiwR7OSZU59HQ+dFJU0FUTXKlp8ZAVq3ElYyZZgxaDu+EwUTA8ueHcA?=
 =?us-ascii?Q?iBieqNeTPmrYr9LdAz26EEaGyf97CuFSYKn2EZBAMvyj3viBDuMIQtKC0i8E?=
 =?us-ascii?Q?YDA0kHb1RN98yCZI7M6cBGvQdpUHYJCSbuWAspL5qzb1YMhVQxfiBrUccJM+?=
 =?us-ascii?Q?BNN3aw2cx44cBw8AZsj8R2hTNKVCvFclYazsv85f2zQGNnwlp5whjbs/F7eu?=
 =?us-ascii?Q?nXyCD/kM+BdkddiS9gHrOwyPXp1/eyVL6sFynojJdkSTgn8X1jeoO0aptOQF?=
 =?us-ascii?Q?bfMv99BW/0737mMSaQfhmThGU67/Jxg9FOSlsu6/gMUAkzoV8D8hwMQtC1s3?=
 =?us-ascii?Q?d/TZegAhDWBpGoEAWLwsUlxILo1J5B9TWFdLp+GLHYhDn7HXPa+uqKBnInWe?=
 =?us-ascii?Q?0EcZ+r9F+hsvZd+o5NGbT7iEW38V18Q=3D?=
X-Exchange-RoutingPolicyChecked: bVUGMgXh5AUiPd4Yp798pRIPy6X5d/oeuqygowK3Hxcbtnz7/Tz/VCon52fkuQSbtt+26qJn7jb55c5mpIpPy/zIUl7i7TUTf7sTft4LygoAjm3sM6p/OpbZViOE/jm7Y8stONT7UXklmnV4i59NoBVcJua+uhSmkb6NN1ikz7O1qnYfdQkSJTKFYSzNsjA+TZ1EerWroxtORIHZWRmEFO8jn9VV84v+K0ncDjrsEZlqw/scQxXCa8TUO0/e0h48crMlRWJ1aAyDxJsxMXHXQ7DIa5JCtHs5dUUvEAqH+XXvHBADv9ORCSZW8LLv530Sy1LIRTj0WTsGsTUlq95QDw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 50562ccd-c9cc-4e13-a0a7-08df2e1ab7dd
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 19:54:00.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUwsmxsrNOyRj84JslEIQppoP/4E7WnAkI/qqO/YzI3VIwoVzd4ggL672QkaOj5ko16dbjBCzsIz6Z3DpMH3o2dNZdvnT7VXTT/a4Iaq02k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB831931
X-OriginatorOrg: intel.com

On Mon, Oct 19, 2026 at 03:31:29PM +0800, Richard Cheng wrote:
> On Sat, Oct 17, 2026 at 12:19:49PM +0800, Alison Schofield wrote:
> > From: Richard Cheng <icheng@nvidia.com>
> > 
> > cxl_switch_port_setup_targets() calculates peer distance before
> > searching the existing targets. When the endpoint needs a new target,
> > the calculated distance is never used.
> > 
> > Move cxl_port_peer_distance() into the matching-target branch,
> > immediately before check_last_peer(). This avoids unnecessary ancestor
> > walks and per-port region lookups when adding distinct targets.

With cxl_test, the x8 region in cxl-region-sysfs.sh reduces calls to
cxl_port_peer_distance() from 10 to 4, and the x2 auto region from 2
to 1. A misordered-endpoint test confirms that peer validation still
rejects mismatched peers.


> > 
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > Tested-by: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Hi Alison,
> 
> Really appreciate for the testing and if we can, can we add the testing result
> in the commit message demonstrate benefit it can bring us ?

Added the above for v5, taken from:
https://lore.kernel.org/linux-cxl/atLBlibv3kbT7xv5@aschofie-mobl2.lan/) 

Let me know if you want something else.

-- Alison

> 
> Best regards,
> Richard Cheng.
> 
> 
> > ---
> >  drivers/cxl/core/region.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 4ab5a1d025a9..8bfebe3e1025 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1485,10 +1485,10 @@ static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
> >  	}
> >  
> >  	if (cxl_rr->nr_targets_set) {
> > -		int distance = cxl_port_peer_distance(port, cxlr);
> > -
> >  		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> >  			if (ep->dport == cxlsd->target[i]) {
> > +				int distance = cxl_port_peer_distance(port, cxlr);
> > +
> >  				rc = check_last_peer(cxled, ep, cxl_rr,
> >  						     distance);
> >  				if (rc)
> > -- 
> > 2.37.3
> > 
