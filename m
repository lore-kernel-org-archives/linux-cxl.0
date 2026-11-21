Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795225974;
	b=yF7n8muJUF74HS/jCSfwNHbyWNDfb6SHlBYeT6pmUIAGXcCopBIfzv3SbSOuQlI6SwI9
	 BGPLwptwiBHsEikjc9F9u+uhGzKV5wzAmRmFVUxWO6iOz3fWQGhMjSs83i1JAlx0y0C3F
	 fW/j/KJNdwcsRN9xl/YiCJV17RWVJoGTOVZWI/9oJPvjQhQD0ELa5c2Wrm7RWs+txv3F0
	 72kvIgCyjMR1BcMeARmhSeVKfkAahYCqNKXi/WtIXPAJAKB9VXp081+2+9iMDtkFbHxGG
	 Jbdrt/6hM1Jj19VoL5cxLW6gp21wbrSok7FyJ3Xc/zU9YYU8qIqbxirh/uuwZp1bl8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795225974;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
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
	bh=4SuFPoHFJFQkMdbkw/EbnO69THx4kyiNbO+nNZ4u7dQ=;
	b=iOA0mvVZMc69HQTr8lu5ir1XesvAQSifnv7bVvg3lzZeCNGVw1+Rlcun6poMQoiItZch
	 EMXSrmq09i5AWkcVdFVYUoPwZbblU1J5CVQo+WhM7p4hvfwekDAJJvOWTLOrPFSL+3JOE
	 DaNM3c1f5MbRr4fZ3fctcUVLnkhoS8r5IlVadsNAlRGUDTUYvaAikP5Tuzm1WoWQdHQf+
	 owFPHCeDQYtlwkHE9G0DjRLF2HWRMfqpkXWCr86fa6H+xv3XcX/3uNvDQrLIgjUTJkmaq
	 XGekM79ehGk+ZuazycEkDm0dPWZXyJii/Mst7jJoS9SSy4FDi0foBgg060y23l0Nmew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YfzWCMkk;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VX5wAhEG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD9B606A6A0
	for <linux-cxl@vger.kernel.org>; Sat, 21 Nov 2026 01:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CD9B606A6A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YfzWCMkk;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VX5wAhEG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795225972; x=1826761972;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qQc1F62T6f/OFsnEsPPbf+Qg8vFp0ctl6/ETUBIaIXU=;
  b=YfzWCMkkXP2sSJsKx7zf7RjH5mO7K7nm6nGhu8vPCR7qsDJRu18HtGB5
   jQ9iIu2JcgBZX0KWE8yUiAeOo06XGlUAq80PB/Xo16UWc9FOZ79idZ75v
   CeDAfh9ZZjT6TOI2mnpmVKmcmIfYt5ggpCazGdXhleZlNu9FL1E5Hc+6Z
   EKw6DkjyEmxeT5IzYFkbZvKV4ob0tU6cFHTDhizohZDT0grE0H3jeCFoi
   s/jZPG0KXPTuvHUcu0N92wzGl0Tq+7kBapy4v7C3f0zBcOtedpbvuoD10
   XvOlACaxZXVsfeQC3d9jIdpcMdQ0YaVqompiaxHCtp+zEB0sCWllCvIs6
   Q==;
X-CSE-ConnectionGUID: qQdIdLoSRDyyii4Ogfx8Lw==
X-CSE-MsgGUID: xNaCAZ+uTtSQI2LoptIpHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3995466"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="3995466"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 17:52:51 -0800
X-CSE-ConnectionGUID: 7a5iPsPHQaWzh9qJoU0Yng==
X-CSE-MsgGUID: cx0kMoHLTziByeT1B3BQaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="12659960"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 17:52:51 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 17:52:50 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 17:52:50 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.46) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 17:52:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNfKumeACBfh+KT/wHFSY0Wn9EwHTodOpo2DfxUfwdTvgRc8CqohwxKE17sBwdgKYdyIz1imaX1I8oFXXLlv+ZJ1IN2//usZPcxTYRk9sh5zzztKa1Irlue9CZdd6IeBe2Mir91aDW7jVobxrYfO49piLkIfmfTZvEARpA/Tejtu5RuMGsNoOiICI4HTQpLceIEFfNgWTFuTk7E4h9fZPPcj7A993PtuqjQWkIVx73CRjrkmR5AuIv25P3+pu3+ZBDUgypQq8aAAcHFI06hJn95uhGEWft/H43VHrym37IZQcz5l2o6cd9Si4FOkIAmYnhHrLjoovdr+jPjcJVHChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SuFPoHFJFQkMdbkw/EbnO69THx4kyiNbO+nNZ4u7dQ=;
 b=p7xZ+aFoq9MjB1kdKbCPvS6D2xPnLpvzny9c3P1h0pKfCwndnm9++TN4vjBwcEpxQNpGnWBbAuQ9o/I4JFqgdRSWabjzHvIYaU7U9YcIEahSeDrjH1hlWqAa8o551+5EbpBYEA6GOuO8+ahvvKCBVlFV8AXhvjgmW/B3f+2XOolsiZrhl7bLKD7+C9XqvtFEDZfLwyX8wV/NhnsUnC6xbYwhJh9Gdh80ToW4OgsWgLLtGAA+kjVWxtTrTMJO8sdPp23cxCZElPbSfViFSx0Z+f02zM1kCdKxWjc/5c9Bbbajd/JMunj2iooilJ7F1z8HXra1fo6U0XwoY+3Zlmomfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SuFPoHFJFQkMdbkw/EbnO69THx4kyiNbO+nNZ4u7dQ=;
 b=VX5wAhEGqF7TaB4Eyy5LDuQVoNr/1n1+bRv4oZQLChJ7KkugEIACbf2G8Ky95f3VW1nNUt5OeLnd+HACrrjiOLAk/+OUq2GofGmZZqyXOwa8AT8RfjQDocL88GgfWRERLlnJuv1ic/X1Eu/T9VFeyOS1/ruwTNx/6xnMxxpbcB8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by LV8PR11MB8747.namprd11.prod.outlook.com (2603:10b6:408:206::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Sat, 21 Nov
 2026 01:52:37 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 01:52:36 +0000
Date: Fri, 20 Nov 2026 17:52:32 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [ndctl PATCH 0/2] Fix cxl-translate.sh test failures
Message-ID: <awD5YKbS1R6xGW4n@aschofie-mobl2.lan>
References: <20261120071415.29279-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120071415.29279-1-ming.li@zohomail.com>
X-ClientProxiedBy: MW4PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:303:b4::14) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|LV8PR11MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eec9d26-e3a6-4ec2-a7be-08df47721ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|6133799003|18002099003|22082099003|11063799006|56012099006|261022075727099003|261026121527099003|261026140227099003|261028144727099003|261021123027099003|10067099003|261021121427099003|261102123227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: tyf1Ku+yMDKfOtKFO79KslceqhF5e8h8K6CmwTHxwA+hH/AhWG3eyqn0mGnXJL+cWgz6u8saSIsfq3TvZQPxcT/7F0qQmK9oSVORM3VluE0pvrQhzq7Kcz38DHagXLuQimt6R4tDDfS5LNrxzpOZBX5wXfKQ5zD9AMCsUdvV4qLDyS3BGpiEkNRIm0uByJssEbsX0zZyOxAO+Q8S8CioEslFbpfpGN58WhDyoe342lphX3PPmmQ0V0mXpNrtdVIRYR+fyI9XH+jM0qXLc/qEi44kjzkNNv6uLTFZmeaF+XaTeGmG4AUhyCg8Jalv4hL9evRQFvTbHZN+iZLepxwUUawofzstwFR+P8Rkylj0ONx3HSO/OWZ7wiJ/EanYIKAtxVEWWsmbmLXohQNX0uvUFov46mR5LIGXbsllr45ce7uaj/MEpwH13XOwM4VXh1gQLqx0zgz5PezMttAbRcyhmHk7Ah4by5MU8MNCEf+zKZMUBzkMetlLt9t56WtPzUrHgT+Bh7uw21HMd5N5umYCqoDJQj4FbzPPWdw7+jiNsxcAaWFrQ7o2RQIHLfzmlqF/Ts+4Xg1OM0z6o71iyJeB+bZVF0tz+Se9nLiAufWhqdWYhw1iqPY5WWD0cnI8FIvuqb67PKoRyelAd8djMMZIVWSIjLYLv1RELccToQJ4s6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(10067099003)(261021121427099003)(261102123227099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?miXIYTfxOD1w/MgAYDug7C7X+MOQtzruJIpavUAn8g/xwm1T8AdgpfUoRhn0?=
 =?us-ascii?Q?pODxUiKjRSW63ihwoWTUF320+dEqYzXYmvcjGdgevaiYkjqB7gnDDDTmvHkt?=
 =?us-ascii?Q?o7XO/JKw1dGZRaimgcJ4OjObWqMBCulY/XzLeDm93NiiccAOCFUOI7i+vfaT?=
 =?us-ascii?Q?GcEjvKW/WB3JGQ5RhEPasT+3ioyvJtonUhl7pVTZxGD5qz5lxaxjt5okiiso?=
 =?us-ascii?Q?eCibioIvl0h8pt4mWVhq3uJibdp9KAG1I9bXbvh4Agw+Z/4HFhj3qVyVT2NV?=
 =?us-ascii?Q?SJZG4lt4VMmyBoIS3z96ysQs7trX+kTplUCv/CBt4aWJMbJLw2UkTOD2kD41?=
 =?us-ascii?Q?RAVX3S/MdRnyCxlQhIusSzcTLWx2IDLQm+2ID3F8ZN2F9JpwIw9MYeP1Ddzr?=
 =?us-ascii?Q?lG/JSYYOwobpXIQBMmbn2vzdtxiO3VPeJd8ghf8n3F2FYkP4mBWhRsjXmNA9?=
 =?us-ascii?Q?ZgeKLIDnDrtDfqWTUB9kNbDdlDn0p+xxa4/gEA9zF0oTrnCepYtt3mbZ4QFC?=
 =?us-ascii?Q?+ezVzzC/cIbSikZ6WvLMHWTyeCwgw+g8Ry/9ZghjutY5+3t0sgkDvsjSRzfr?=
 =?us-ascii?Q?3TbniT4dtaOhqbZD/QpgI4yBgNwGkf6w77g2cI5JE/iVZwQWoCkYLuSqnHTn?=
 =?us-ascii?Q?3Je/bK8JgkQIB5E+EnwjFjMqXK82ddBi/DTE87xoWk5uA1U1Ui234C/xwPPd?=
 =?us-ascii?Q?Qd9noGWdgWVA5TMqtbprvIW5LEHAR9j3heyPIk/WuZp5Xi1qkYYQN2goV/7K?=
 =?us-ascii?Q?ASiaNrMMb0bB+iHrZCPdPnjGO/KDHdnfbaZaqEG0BcU5N7fSM9feWkVb7vHB?=
 =?us-ascii?Q?ug5pRTtKBVSM4CJtxcC2tdMvNqvGfclSJmdTRNUBTFUXWL1iiSowPKk8WqyR?=
 =?us-ascii?Q?vfMLib7nkiOJLoNKG7J/+64jvZmYCPc1/8oWDBD+V8hLFjx9tp9baXCovka4?=
 =?us-ascii?Q?DPwg1XutnFI31U+Rbu1jMzbWtUgg0cWMNSi4CBnNUqXctHASefq9V5AnSeNe?=
 =?us-ascii?Q?MVUyZ30YD7sJFjfHDeOCe0tGoA6viOhE/9ls85HvsA5JqypuX1cu+ov6f8Y+?=
 =?us-ascii?Q?NWasC6Rqz6/DeEnvfbXXW1o0sUtdSfyctquykGvtJjCw8mPkmU+guW/uUPwi?=
 =?us-ascii?Q?NuPj7k7a9FDtcbqKOctW8agEVhRAJIlVdcHLrk8OuPPnnG72KI4DtH9i3DVB?=
 =?us-ascii?Q?RieG4KcPUr0XpXH9zFQ90me17/DkDXDFRVUujX/8BKK78NmE7Ilb41wvnaDG?=
 =?us-ascii?Q?cWwqGNu3Uf4UNsx4Je9pm/9y+TgVwM+glr6iwfowLnwK3bJba8lMtNw8Lz2i?=
 =?us-ascii?Q?kn1N2N0GI+8wcP7r7r/dgzccOgNqaVC8QOGHgDRw+RNw8dfU9++QRearmq9i?=
 =?us-ascii?Q?sT0NMPA7J2ZztcivX3S3vxEE3T+VqJoYRy8zPxwecHMXowiH+wZykHjCE8rQ?=
 =?us-ascii?Q?BepJ8Wwjpe7M7BUAONviL0Tsmv0HkE5cc7AFItETyn8vJa/EjlDlIj0LP3yk?=
 =?us-ascii?Q?adpdEjGYcQ3uDp2gdS9wg08UmG2q+9eEr45tFDlWWQMAu6780zuApVEwWaHu?=
 =?us-ascii?Q?AHCG+amidOdUoufTnLundHl68W2Z+sOx7E7mGr1DOlw8sCHm9Ds+TBD9bnth?=
 =?us-ascii?Q?2hRsTDC5sgrHRimF9HI9wWngChUPa/zbit80mNY6p898FGnbvZauXlVEZ1i5?=
 =?us-ascii?Q?PZqMyjXiKRZP+w8GCZhMWyJPKRHjJFY4JsL44PBr+ElJmShhOZ5lnUlA9I1I?=
 =?us-ascii?Q?W4mxGbybKHeEPmb3Qk3KPE8ViyVTiQ8=3D?=
X-Exchange-RoutingPolicyChecked: Dx5YIRbJjod13QdsOv6riaAt8MY2p7Fj+V24nwBjfd8Sunv6c7++83IyTxYEHJbjyts+78fmQhtsQOrHm0ozsdfoVj3jRnlglH+jNcyQmf4x/fIFXbl0Q5QYkZmSPbOPhVFebtBXf2sGpRCyoiZCqBqw1fZNSHRCZNl6QW2BBEtuzurToPwjZnk7N3tnI0q3w2M4tn0wsM5dpHyyzYH47rA2wSVIkejr2aug5e4Je/AbSqY0c8Fd9+WIQqdsuh+55q127pfcbklwmcHekC9DkNyGVrUJL8vZeHoH8olukkINjnMl9m3zgg+7LVWD+foZy4xtkXBt+rWNBvn4L3V3rQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eec9d26-e3a6-4ec2-a7be-08df47721ddd
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 01:52:36.5729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhvNRlYPi//YxA1YP134AEV05H3r8ePOpenXbYOJYqbn2Aj3xUVlML6oRI+7o7FGVgoaSBL9dUdTV3QpCacZ9F6pE98kh/FEAqXCaYms4vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8747
X-OriginatorOrg: intel.com

On Fri, Nov 20, 2026 at 03:14:13PM +0800, Li Ming wrote:
> When running cxl-translate.sh repeatedly in my test environment, I can
> occasionally reproduce test failures. The failure point varies from run
> to run, but the root cause is the same: the test is unable to find the
> expected kernel log messages.
> 
> Investigation shows that the expected messages are actually present in
> dmesg. However, immediately after "modprobe cxl_translate" completes,
> "journalctl --reverse --dmesg" may not yet have received all kernel
> messages emitted during cxl_translate_init(). This timing gap causes the
> test script to miss expected log entries and report false failures.

Hi Ming,

Good catch! Can you fold patch 2 into patch 1. Both address the same delay
between modprobe returning and the results becoming visible in the journal.
Patch 1 can still fail if journald has recorded only the first PASS or FAIL
line, and patch 2 supplies the completion marker that makes the polling work.

-- Alison

> 
> This patchset addresses the issue in two steps:
> Patch 1 adds a helper that retries fetching the expected kernel log
> message for up to 5 seconds. This mitigates failures caused by temporary
> delays in log visibility through journalctl.
> 
> Patch 2 updates the result checking logic for test cases that use a
> specific translation table. Instead of treating the appearance of a "CXL
> Translate Test.*PASS|FAIL" message as an indication that the test has
> finished, it waits for the "CXL translate test completed" message.
> During test execution, multiple "CXL Translate Test.*PASS|FAIL" messages
> may be emitted as individual checks complete, so the presence of such
> messages does not necessarily mean that the entire test has finished.
> The completion message provides a reliable indication that all test
> cases have completed and all results are available for verification.
> 
> Li Ming (2):
>   test/cxl-translate.sh: Wait expected log before checking result
>   test/cxl-translate.sh: Wait for test completion before checking result
> 
>  test/cxl-translate.sh | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> -- 
> 2.43.0
> 
> 
