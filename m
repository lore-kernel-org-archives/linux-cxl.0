Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF012F5A3F
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230828; cv=fail; b=FoPJoBYFizlLL4TBlEOYLzsi4iIc1YxCeIFzCk910LHXjqu6qIwYnBNVNTB2X3Lqk775XMQz9FECG1o8D7pY0lsIZcBaMVcpVEFO3xq4q4QTgPY/tYa2wgGgRhfw9QHvmGvEbslsWN0B9PF5L2tYJHkevKrJ+OgEKP78swUGvmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230828; c=relaxed/simple;
	bh=fidwxPXzD4UjFcWrAdpB85U2c6MnGEWe44N6szj2bso=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q9xq+xPhcyiOxdrTSM3WWhzqP49JxIaanc/ZaDkFgLyvyHLj7JIOW9Kt+H8QTQHgXG11gp2qKeCkV0Y7oA3QEqqTu6nIEI/QcXHxxvB4zMq/42Rr6MatJkaRcl9Uwa3gJ6ORtrJSJa+FtwxCGi6thRbNsatIhS3D6RTIBZs3dDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1XSeTJp; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1XSeTJp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758230826; x=1789766826;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fidwxPXzD4UjFcWrAdpB85U2c6MnGEWe44N6szj2bso=;
  b=h1XSeTJpelo1wl3f+Glkrs2Bi90nXNMzN7z/CpAB9OTyfgfcsQGgtflN
   ukd6agaP4lfrVS0TJKPHGeboyoLhKi3fX9dN8dthe9QWQSdbnYHuhanKe
   MbX8HSKfUBE2B+xw5oAknwojRdbdB7v3svUQSOSuu/IKMsPZts6bFiXAB
   k6lFFHSWEcIsX7LwC9yySNZ1tcHl23vRlqllCaypRqq+dicRQv5SUpm2i
   zrvveEGB4A2FHSwoRHsSCnx+Lp3AmNwVu3rqYgDgXh6k2huY0vDe9G//J
   alKt+ucIhujSpuOI8o0cQ4Wq9Y8OFckFN1t6/tqVmPLfe7cAHY9UVP2OE
   A==;
X-CSE-ConnectionGUID: sBvuISo5Qmy6CV/e2rEfIw==
X-CSE-MsgGUID: OOV3osaTQkqleFSQ8p22Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="72005416"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="72005416"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 14:27:05 -0700
X-CSE-ConnectionGUID: AQZCMb5fQaSHO0xLJ9tSTw==
X-CSE-MsgGUID: 8oJGgY/ASUCYG3KnTtAciQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="175217077"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 14:27:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 14:27:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 14:27:04 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.30) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 14:27:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGjyiWq2z0+jV7NJvzr/uqU1Os3V1lhhM/Bfa/ZD4DWNkjeR1hxm0RgmVUnOhqIL2CYjEfePwOD2b/QGq7LeqHVfUorSGQAYhXIUsG0GpywzxCmD+2nVUYK9OYrH/iouXyh1Jnni/b4XzU3XyRyoabut1pju9Vq5Vv7o5RLdO44ebdhXg4a1sFyh6tuDXBQTRvGEZ6Q9QmduMOV8OpwGD0B80M8/2ceuTRl4yCfggykmNze1dsJH/ZLGBrd1+Axevw2EEaugusjH30gwVhJD47MY1SFGffRKACvX0nJA+JolQq13dXqbE+eYVyxaVq7k1t25EQHqCkSWFNslKWLexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTZDuw1NcXUxnHlh6k/3t0ZiuR1cc+4v+QjpIX4y5J8=;
 b=ev3QIaBfY9KPhsiBKMR01aa8hF+i2naHoLSVSy7C4m+q0drmdVfhkHRdeqs/e34q5f4nU4obqn8blCDPafZmwRQo7iCox3G349hZcBousKiD1qTAw4EXCoF9UzjWT/vaCHitJ7sdGdzsDKU9OeksfgP2XzMlRPS5qOsrzUYTzabx3COCpJ67RvMI85iJ5CVOU0xELlr64OaSdaaWSo2Y16JhHl663vZLC+N+W117SA9ubu/qj3+E4kwDacd9wSTUdXkzzpVxbOc3JwlMNqJ9wdR43y9ije2DVz1zYmYTp2X6NhqVPEvRJRpKcP0SNI5JQShfGi8ItWw6k+tIYV2lqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9131.namprd11.prod.outlook.com (2603:10b6:208:55c::11)
 by DM4PR11MB5970.namprd11.prod.outlook.com (2603:10b6:8:5d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.23; Thu, 18 Sep 2025 21:27:02 +0000
Received: from IA4PR11MB9131.namprd11.prod.outlook.com
 ([fe80::7187:92a3:991:56e2]) by IA4PR11MB9131.namprd11.prod.outlook.com
 ([fe80::7187:92a3:991:56e2%5]) with mapi id 15.20.9115.020; Thu, 18 Sep 2025
 21:27:02 +0000
Date: Thu, 18 Sep 2025 16:28:59 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH] cxl: Move port register setup to when first dport appear
Message-ID: <68cc799b60225_194a3e29483@iweiny-mobl.notmuch>
References: <20250911204406.2454689-1-dave.jiang@intel.com>
 <68cc5df08dbe3_18f197294e6@iweiny-mobl.notmuch>
 <b928abb5-17bb-4c6c-863c-5f32db3b07d5@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b928abb5-17bb-4c6c-863c-5f32db3b07d5@intel.com>
X-ClientProxiedBy: MW4PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:303:b4::19) To IA4PR11MB9131.namprd11.prod.outlook.com
 (2603:10b6:208:55c::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9131:EE_|DM4PR11MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 347d5f47-58b1-46e7-6989-08ddf6fa1bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SXmkRCrf/Nd8GveoDH2nr0ZSOM70xoqT7Dg2MLioDS0QbFOZVvQlq1bNrzqt?=
 =?us-ascii?Q?7Qy8mzPqol3vSofe1+DtVPVDHJLAl+3q18P/3+tl92zhYmYwhG50uFPztxyX?=
 =?us-ascii?Q?1PdI+LfvVVIUmjVSWox45kfaNhO4ORRc6owO7oeyS9gO9v7c8haLaGPmjswR?=
 =?us-ascii?Q?1u8b+/7NXfhjhjzr/bJuU8alUpvDb6RM7BU+sTh5eqqiWPtQhN2ThyirZmwe?=
 =?us-ascii?Q?7drWbGc4m89Rn5+eFq4Ruekk/GRjGn7Ahgr7VuFySjTSh2HpgtAjvBi7sCLu?=
 =?us-ascii?Q?hmyXCeJ8sQgZ2D8hmJD0Es1Cd99FBUpcZ9bh6Scd6rRfZ2kG99ivXaYlTQLo?=
 =?us-ascii?Q?vdNIgrEUejx/GrLb7OOTsq0DQBU3WHf6hulH7jc3k9qffsZnabDZLwLV/G+U?=
 =?us-ascii?Q?wOb4EXJz4UHdrsEIwqTlsseR2UIDJDwhVD1udnYJOfM8F2aPBP1fZF2bl+Me?=
 =?us-ascii?Q?nqcped0BGtJ6KbEvgtB8G5pmpOH0xrjaaEaEPo6tfwuF1cBxsOX2q//iNW5W?=
 =?us-ascii?Q?I2n8KpzIiU0vkgxmfXw7hItrr1xXHpi57ZXUtIwbQgqzKQa7X1omDywnUK9s?=
 =?us-ascii?Q?65Rr03DQibbUUk7eCMI1zUJFd57cLUtVwQnJuwN/NtakmcGpleyHaU9movZg?=
 =?us-ascii?Q?YqQGUE8nh2Nb7/uvgTXGVN/m3vSCNkL5OKIKFOxm6LTvYnFWz7rIPvmxt9rC?=
 =?us-ascii?Q?541/0Ioso2yK9MlJSFzbAHck7/01pKHEw4X5fjazrjCLitFg0XtBfrThhvDZ?=
 =?us-ascii?Q?FUDQw1zcJcpo8n/XHvvEIk9h/FE6dLUCVdK/Jb7xV8BnlYcf8bo7cPVPNPqk?=
 =?us-ascii?Q?KBCDUjyp/yF5nh/S+kjT0OQm8I/EgKx6HMK+gR338gFFGRr/6s+jQJOw4fdC?=
 =?us-ascii?Q?RlwvCbbWwPJ8RoiMPqXAKbMkKBpoQwUmBFegnMHT5EV2eJVTmXIPXp6ME+28?=
 =?us-ascii?Q?VAmJiwCjqW6oHhEZk7Ea5438v0xDJ1FGySPcCCMgWi641NJLBvhTuXVsgBc9?=
 =?us-ascii?Q?fhwvaBnOXnNp5I73NhgNqgz6K/D+3XpRm4kLIIgZyJxDCRT41X71RV7YjL9J?=
 =?us-ascii?Q?SUFvkFKtWmo6/G9hDw8OaDgIYQzT89iAM00yyQ9dWcY3BsfzzcOCAG31k6oq?=
 =?us-ascii?Q?BwLUJJrYHPLDJlskcYnZyzPVyvVnAMMz0WPeqP1ydFSkKwWu7ym8P8/TwBsL?=
 =?us-ascii?Q?ibwEjIVHQtB0TYPbm1Ha8t1pk5b1nyeOmSh0yUk4oEwrpVQO0xegXBMObG+A?=
 =?us-ascii?Q?5O0Eg3cuyvkAvek2Ck+ObL0x4d78UZHBaIQs7D6hAvdxQ/YIhCN3SFbnojzg?=
 =?us-ascii?Q?7qoIf1lOQA28HzCVQjjvezAA57tyybpmDZcTCc8rHy+sXo8yrwdGDir8GR93?=
 =?us-ascii?Q?yOwWLThMaxVVYCDXKT8Ko3nDcknwAaXN6fKA/n5i9CS51P3XkvLJW97kP3ps?=
 =?us-ascii?Q?R/V0IufDhVg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR11MB9131.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ifsriLsmTgz3+2W0ljH4xUSovKAG73J2pTULU3jRE7POtZOfxVIrs2wTPedb?=
 =?us-ascii?Q?N9PPVdeHkkP1cf/VKzKyfaHOCdfNzcqEjwYt0i3+x63MiyyYmIdoXkbe9IhE?=
 =?us-ascii?Q?pdqbE45q7+9j+3rXFS9gwabjOKrRksEAw5ZVnYpfDvyN14Wy/XdegB3ES7dD?=
 =?us-ascii?Q?RcZzcDkmNV6Fyy+JxjIzp8FB7fRj4wV8Z9wPwqqB/B9ZDK2c9VGe4s0iMFo0?=
 =?us-ascii?Q?e14686zaF1A817jiPbYa1uU7uWGO8WYQKH12x90VaEFRYimV42TfNIkojNPe?=
 =?us-ascii?Q?B2ESvhzMyQ6rNvjqVktrJY/dSsQNQRimhniRVmLdM4PB4gpvWfkDiJLYmQ0h?=
 =?us-ascii?Q?H7Aa2Ia53F/PfUxjn38/BpnxMwOsBEFxPSsopBs7sEXybGh+gGXfQtDUKtuK?=
 =?us-ascii?Q?ui8FpgFotQReAKrRGp9Q8XPuHwAJCm0WK6tfu/YWLWeWMWSEI+7Q7EUt0enE?=
 =?us-ascii?Q?uHXhwHKHs7wyxtU7jKtjlV6cWSKTQPDUlV0eoxI68dG3E5zYvc6KCer00p9A?=
 =?us-ascii?Q?GG8xbi/dlUeIH6pUczcEx1v+cibgU83T9KKLBn7NzrzOMeHjliItJbyzCpiG?=
 =?us-ascii?Q?hPZwcP3nIKUKoThTcHZxl2NdJbKrdiHkLVKjDyHB4IBl+ztkAA6HsSI2vCYf?=
 =?us-ascii?Q?meQIqilOgFBrOkyjiRdEiK2hmjnJy9MqzUnO2FMIlqObbMWIr1k/iwx78tBZ?=
 =?us-ascii?Q?wtvlkeZqzMSma56zNuaUAsxy5x0/FtVH0DTlkL0TZz5k9FrfsImL5CopTqw/?=
 =?us-ascii?Q?DTfhQ2E8KS96oeAfejQLRbka9gGS81eR+Zj9y08KVVYCgAMEVnnVlYdq5mwA?=
 =?us-ascii?Q?YQ6kzLYBw58mJSBwAl5zjwDVd13OnvdW9UavyXrUT6wS6JAsIHNS9mHPRAg0?=
 =?us-ascii?Q?Ani88iaku8iJOTqv+NHhZJBsnuOJXECa/Kh7VRv3vcGQuKfW4MzrplzMspYn?=
 =?us-ascii?Q?1YfuAgtWt6jJp3IBxlB/OP6YQm5eIJoMHNIWA2yDnRg4+kjnasBWgoOoUHHF?=
 =?us-ascii?Q?BA84aFxZwK1JkHyvmuYkqhnDRY5Jn0rBd0hdbkEu17usbjFdxdYDcfUX96iv?=
 =?us-ascii?Q?tm8AMQXAc0Hcgmb53o6TFa01d+asJmXLX2nQk99kwVeynAPfOnUe3YDRLvca?=
 =?us-ascii?Q?rXDT7nQgOFUMi1qM4fTlA96UvKS4G6268Gmsmot6rsLVq+8Du/0BrSUnJm1i?=
 =?us-ascii?Q?1wFIhnzklMW6i9ixhAlDnVQqXum3zy0FYcCW3+MDir2tpuu6o49KtMdDyYp+?=
 =?us-ascii?Q?EvDVFJzqtiFla1Ix6yaHc1aiRWZiTbf2kdY5I7iHiP8TGCmiJwB0FCxIm3xm?=
 =?us-ascii?Q?zIziNx40VWsatyKnWzRTqC4On8P+s1cFB2vs60JUolQiLPlAIo/ALGfSB0P5?=
 =?us-ascii?Q?GU+Gb9qEbnlFuycyTobOWR5Y2v1CL8YjUorLReVCGAa/oJFOF4+EOIUf0uap?=
 =?us-ascii?Q?VIdl0oTIRZcSbgeB1hdn7GLPUbsvDKZP9+4M3BThbEPFEn3CSg6b7x5ISo2d?=
 =?us-ascii?Q?5KBDHL8V9+YZIZQ0Tm7cTrYFJ+3BKc+swfEtC1m1jkcYGOM99/Xp7Cf47v2X?=
 =?us-ascii?Q?Y6lM/th6shE/gUekHpLeS/HzPzQDP/hWzj4Jhkwf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 347d5f47-58b1-46e7-6989-08ddf6fa1bba
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9131.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 21:27:02.6163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBX5FiuTVjuq6H+2HGkvtzkE9T09I4ylBMDMv+Vg5AqUk8Y52TKY0OamjeOcmhu2VKxvlpOO1NtcwCxITd36CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5970
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 9/18/25 12:30 PM, Ira Weiny wrote:
> > Dave Jiang wrote:
> > 
> > [snip]
> > 
> >>
> >> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> >> index 76dd06d282df..416d45516d82 100644
> >> --- a/drivers/cxl/core/port.c
> >> +++ b/drivers/cxl/core/port.c
> >> @@ -867,9 +867,7 @@ static int cxl_port_add(struct cxl_port *port,
> >>  		if (rc)
> >>  			return rc;
> >>  
> >> -		rc = cxl_port_setup_regs(port, component_reg_phys);
> >> -		if (rc)
> >> -			return rc;
> >> +		port->component_reg_phys = component_reg_phys;
> >>  	} else {
> >>  		rc = dev_set_name(dev, "root%d", port->id);
> >>  		if (rc)
> >> @@ -1200,6 +1198,18 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
> >>  
> >>  	cxl_debugfs_create_dport_dir(dport);
> >>  
> >> +	/*
> >> +	 * Setup port register if this is the first dport showed up. Having
> >> +	 * a dport also means that there is at least 1 active link.
> >> +	 */
> >> +	if (port->nr_dports == 1 &&
> >> +	    port->component_reg_phys != CXL_RESOURCE_NONE) {
> > 
> > Should this be
> > 	    port->component_reg_phys == CXL_RESOURCE_NONE) {
> > 	                             ^^
> > ?
> > 
> > to match with 
> > 
> >         /* Note: endpoint port component registers are derived from @cxlds */
> >         endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
> >                                      parent_dport);
> > 
> > in the memdev probe path?
> 
> 
> No. port->component_reg_phys gets set in cxl_port_add(). So by the time the first dport shows up, we are using it to setup the register and then setting that back to CXL_RESOURCE_NONE. So therefore the port probe happens when it's the first dport and port->component_reg_phys is a valid address. 
>  

Ok I see it now.  yes I was not thinking correctly in that the acpi path
is setting the component_reg_phys and it is being saved for later...

All is good now.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>


[snip]
