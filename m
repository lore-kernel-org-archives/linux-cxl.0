Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BC94644C;
	Fri, 21 Jun 2024 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718996696; cv=fail; b=X2TI4kHhGgpaXdxtQH+qIb8nvMDr5pdcxVmsUqck1baS0CQAYQC4rF+Pe1EAcUTYShj1HG2iKc35Mt/kKCogqJzmL6/jkeuVSnC8AITOdRvAzvJCCioamob2Pogf5I6TGoTTT1oow9d/MXz1puDP+UvztzC6slbZzZkD7931sts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718996696; c=relaxed/simple;
	bh=Q9K4qxGSl2IF8T2pEdRkt5tuqJK0CRqsSn4uxwE9nqU=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X0NpDW4Ri/hnuH6FJPdAw5leB79Vh/hYwsjHVuwQ2ytDTGHJ7EvyFqmsjXCa6tshDiukbS5GxRkVgSUm63ZVeLPK0aowNdvMLiC6bL/oZw4SjsG521DB/ERiiJ1WyLlyDfyllQZnYjXgdZ2dN/3oKybGhfWB+LqgaTSJlfcSBD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QDD6CAei; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QDD6CAei"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718996694; x=1750532694;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=Q9K4qxGSl2IF8T2pEdRkt5tuqJK0CRqsSn4uxwE9nqU=;
  b=QDD6CAeirTHgdp6Hhme/yyMZY+5DIm73eyjcG/b7MmWXUYyqRWqOIFG7
   CKbp1MQXdj+91VNCQTRva1nzyxqyqmjDPpMdV29+IIyTDq8A224MGUQ/a
   UXiDcoDk0uy1tcMq6wuYMhk3FaaMeEHnYyDsxvJl71SOTrRz/Xln8DcDA
   X5HDVSuVy+6gCMkcjIOT4SJ+3yL3sl8vbiD70nsHP4CzIZjOFP7ATEnT+
   mwxmtNuatgqmATCNzhB4FHzDrwrWv5XNwV7rSKpNgkUhQOamN3RcfRuSf
   RtTyIMnMqXK1PQcQ0T2HlzKILXpzkQmdh10sUBsc5VQuLJ5DMtS/oiCtz
   Q==;
X-CSE-ConnectionGUID: 2//bObpbRrGogZ+Z+Aj2jA==
X-CSE-MsgGUID: NwA8xkknS02Hk0SU7w22rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="41450031"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="41450031"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 12:04:53 -0700
X-CSE-ConnectionGUID: fX3oUf6IQIevRYkHNI2f3w==
X-CSE-MsgGUID: 5Vq4NvLPTvqPlGVlocSQEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="43120739"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 12:04:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 12:04:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 12:04:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 12:04:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 12:04:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2FpXspXhz1p3hKEIjUibQ6oguh/AulrS5kOkOsXCVi/jQiAa95MxAix1VAFGh62nmdm1UHvhjxh00kTgNQvurRV+pEXmnOOOJ9k4ehsmEXIBT67cfOjG1EozaL/OOCuAKBsjxiWaQu0HWiQodc5MM6WiOHeeZlz5yBYkU0PEvt8ZDWoNdHQFsn+KShObR3wfBO3C7EvQ+8poq/JUHD3GlvZ+tKjjgAlC1VzxW8RKeNoiX4JvaaVs9/x3IAE8XqQoyoRBx7SF5+Sb7pmuZUD+YCFg/oY+GK9TM64CFo9Uj9+VUPs3EEPCF9qEBAcmo9xkB4T84zyCLEYHDv4JVhAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwu3/atNsnvQxgePF7aTnn1mp9PO5/A3MtWeSxaXZTU=;
 b=c2PhY8p7XSQXqdDl9s8VZvFga1HSKJpXmjQhARFime4u5vWUGFWMoV0ugcRjVvd3JPweGnyVwgeZFzQdigc1iJrgUJ+n1SZbMERs+RYjypv+2ZopoPWlSO7CkLu6uCGmLaGpUWocktpHniRzutNmK93fH+1lzZYZsBczMahBWn8ZJ3p+61k2hYEWgVlK5sXxtCIhiD7xnl72mlhmBK15DYw6IX1+em/4cx4fX6xgJSAMs43GY9FNBz36x0UZyIqq3qVieFdh2ZoKx4ydtb306K0ck0mMbfGLQAJgfM0LGZUVY0pdO4BvLQkidd5Qa0sLg8rWWTMis1qY9rKuJbG9zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7847.namprd11.prod.outlook.com (2603:10b6:930:7c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 19:04:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Fri, 21 Jun 2024
 19:04:49 +0000
Date: Fri, 21 Jun 2024 12:04:46 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Yazen.Ghannam@amd.com>,
	<Robert.Richter@amd.com>
Subject: Re: [RFC PATCH 0/9] Add RAS support for CXL root ports, CXL
 downstream switch ports, and CXL upstream switch ports
Message-ID: <6675cece52eaf_57ac294ea@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240617200411.1426554-1-terry.bowman@amd.com>
X-ClientProxiedBy: MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 75046ac3-5109-42e7-ae9d-08dc92250613
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021|921017;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?buPvdB734wO0iUKlvJjqufzXQV/6NOz3XimaMH4YQ3yvFtIc/30XJ+EAvAHm?=
 =?us-ascii?Q?JsqQHOAIqyw7kIFWPKqwTdAGxFZWuTRd3ia3tK+xooPc0OQg+oJB8Nt3l+lF?=
 =?us-ascii?Q?PBt8GYqpfL+973hEXgdQ03z4SzHP+PO3nTKkAHdHgjWT77QDFROMGlNZq/Wj?=
 =?us-ascii?Q?5sKTzPeyWqnwIdMYDJdVuYK2bDzF34HowBG3GMJt6mstqih1GvroQlLE4ye8?=
 =?us-ascii?Q?9PRypMPNLiHZ4XTMiI5leH6+AR5ngS/UYJpie4dd0Zhn3I77Eyo29XZe7+g8?=
 =?us-ascii?Q?2iJOGFweFPUMMlGx2bXtWBWNgpIT6v5g9rvipD6q6EPszx2TNuv0Oj7Ctvfz?=
 =?us-ascii?Q?B9zyjqFJjsOHuLZ4xYnYnTfa5SG6lqfVELcitpdlqnwxKa+LhpbmvWzLehgm?=
 =?us-ascii?Q?emJOXxZiHe3xgrTTMLP9FFqhFPg8SITkcZYYeaFC6IQRPFIaN/WroDCdfIEK?=
 =?us-ascii?Q?m1fg3rtnqiZa/RiyO4F3PO/rE7i6O+bkuazrtfxAkBlRQtXHd5hQJOTJx/g7?=
 =?us-ascii?Q?6p1uHunQUig29Ld6nNEIkyiRtA+hlh7de2p6zo1Ym+I9UVe6NC4r8dqcR6kC?=
 =?us-ascii?Q?CrTpsrCK2KVgq4BwveMiT4L5sPVU6mWrx/3Pt1Y/xLJXnVMkKTv+ALqhsEWU?=
 =?us-ascii?Q?faJrwfp1NSTfis5r61dZebZ1Fz4+BlWDCR44q3TIrryHfcYjSuGyOMGI358A?=
 =?us-ascii?Q?U9DfwpP8bTNT8L5f48IPcWRhiyRltW7lr1wq77Z7zaFcpEK8x3Ekrlbr/tpG?=
 =?us-ascii?Q?MxyJeMQCPdRCxu7YPmHZoeec3p/rxqAX+uC+cuZpKcBEYI/RlOrf8fBhDbrO?=
 =?us-ascii?Q?w9pPBcQLHjRLHBKh0zbW5xTUWEWW2vOP2pNkGeAWkBq4uf03iBYLF/LzAhaf?=
 =?us-ascii?Q?c0JCtxrV94L7rMKyqIHa2Z6XydNbTvXX2TDID9s/wKiTKQZQNGpe6xQ1ujN7?=
 =?us-ascii?Q?0l/sCQxLfg61xIrIMKr9Eb9lm7BGPHEnL4VhVBKia3yOVfKi/lVlQO7pGlBk?=
 =?us-ascii?Q?BbwHwqk/XLVzyx8ROKMI/xZMwe4RcZRDkb++KfUGkp+7nEFzUbwI5tDSwCs2?=
 =?us-ascii?Q?MU7i96pYvpr4LUzZa1K1EnZwlZdhZabFOY8lzs1Q2C8U7Fmi/Uowrw2/Zv/Q?=
 =?us-ascii?Q?QXy2kgRDJfdNKlVnlz0oQg35TJuWBCYZ6L1gWVWf14Lo8Ty7xxeOjgc9jQpL?=
 =?us-ascii?Q?phRgKj6scmmOnhVMyraDyH7ofaF6I6bILZgBgw14gIeKYs1sB11PzrEmDyRe?=
 =?us-ascii?Q?0d0DmtpMGqsnuixOXFcPjRg9Hgad6MHeNSYdlf7ek63SxlIiQf56uYE7By8G?=
 =?us-ascii?Q?2ulYbOkBYxh0D/Pw1fHN5h9TlGK2qIO8fqbDSeWd70uxBs6aKpi+1bAXYc3g?=
 =?us-ascii?Q?tpxsns0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sl8EA60F6WV2IjUY8NwaD09BDT9+JGluxTM1VuB5BR1LD4b/+Zhu5ZQdvnVY?=
 =?us-ascii?Q?OsdcnssBBmw76xmiWlR0GUJ/M/D2k46oorobuYMZ/vhjQELlBQf3vcXxBq2+?=
 =?us-ascii?Q?TeIHnWWF4LIBrJ5f9aIIdmSWa1qNtDFF7dHt79INXPl89H0bqAWZhBTRcPqO?=
 =?us-ascii?Q?I9IjeCV+QBtpmksb7Hf9yOna6ZMWqDRpD0376IAiWP96Ij7mQeG20cnJ7TXX?=
 =?us-ascii?Q?NdxNAACd/VLpRJYI7v6JV6C2NAR1e5vPwk4E9opZE5scCh0V1V6ZpVNVqUHI?=
 =?us-ascii?Q?wqGwMScjh8EL+L4gRL97/ur1/5+Q3jPDCenZ5oA6BDEByB+uFdmCxXl8OyKT?=
 =?us-ascii?Q?hvMDxqV/Yl1UmXkygkpSS6wpvjvUA1veXgtrmrUoD07/qMHP1qHLErYniH9s?=
 =?us-ascii?Q?ZuYIa82cEqBrmYGd+lS+x2Spg6aPCY+hid0kWCx9TRXW3zrBdOhBbFTJ5Fgt?=
 =?us-ascii?Q?1b11sTI4hjGacOcgo7L+E99BXBDziVTyoE+xQLFDNyz9QVRz/T5TiIcyjxq3?=
 =?us-ascii?Q?7PC7qpJjne2KWiIXcbnMb1LadrFPqRKx1XhoP6PHUJf9dGc2wn8/Drc9AB4H?=
 =?us-ascii?Q?L42DF8M+UFNeYeLYNikv6zkg0fSGe0z/CjFZFC8PsAL2vDcEasYgKusZGFTF?=
 =?us-ascii?Q?2tOCn+6+iqgkSpkSlPjqaGHrXu3idVkIiMd4ZV0GCOaecOYl+3hSLg1f0qxS?=
 =?us-ascii?Q?+mHUOSLen6U1NuybXk4ZnDVhC2MjS7in4yxlzSa4IHdV93K+WXTAd5IrLF3g?=
 =?us-ascii?Q?MzMqx5C76sgsOKFOika0NAyhFymVlR4dVjuF4phLETeouR+1cw9Ayd+0WAK+?=
 =?us-ascii?Q?kh+T9jcIRVxGobbdbG8nLibpbk0Ns2VyJejtBt+LlC16DYYMv564IERHTn7R?=
 =?us-ascii?Q?ZBRTRi/+JgjDM0HDmDGYPrCsm2ooMmh0Oor+XlqZewm4gWEXMakNEjKmBzCT?=
 =?us-ascii?Q?SnXsa7Onr7WGsEJedmvvu/2mIzkNHOcM2bW85Y/rGLYMfCdIIfiegYlKJPb1?=
 =?us-ascii?Q?BYMKlDdK9hhhJxdREjOK5/elJ5nFPu55kWX1CT13hZO+WcjzA+ZeUWZfog3w?=
 =?us-ascii?Q?m+oSKk4JFaW0edUulQI8T7mdHcMLwYIx5YwsXEk9l/7/zeGV23ZmEcYOQepa?=
 =?us-ascii?Q?+hc8lq+j++8YqWzIcJRJ5QZYOrl3G6+k4llx0EmbNnV3EP8xikHZo060e8xv?=
 =?us-ascii?Q?t5g7NKwhdg6nimYS1QEOaR4Tn98SIe86U2s8dui9S1V31jWfqAATze5SYQLY?=
 =?us-ascii?Q?SOCbTWck1UpUBM8NWQy/DrLfjjAcscI72A8aNtaUS9/bq3xRhNP0Mc2EhPVP?=
 =?us-ascii?Q?2Ola2orNeaTx6emkyWZhNU1XurD3d3ggFnYE9hTxuKKB1u4ZBthMnUxO32zY?=
 =?us-ascii?Q?GgATlPApPHqpIvneElVxVuB7WIXXS0knr/FMYXQcEY4e3aAfOpt8G5dOtUw0?=
 =?us-ascii?Q?JP9oswtWlNfNFWFaSKzrm5ct/E8OthA/9/XkN/waHyUdeGEM9iQuzsJTJ8Vq?=
 =?us-ascii?Q?T7x1um/o+Sq/K3oxsgcxZH0aYDAVtiwkNJ2UYI50y0JFr+afdK09e//RKdgm?=
 =?us-ascii?Q?6bQySiTZI92G1K7AQ51xPKf8M71+PTekcY8t7VPgCXdP6YA7Iy47G+Nkq/DF?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75046ac3-5109-42e7-ae9d-08dc92250613
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 19:04:49.4665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPop3vV6kuvFRHMPmx8NpShg7m8q/5iIURfWOwTlJvlZjrjmA7Bt0NSdmEVR7NNmFDC7jnpSfJf2qdflNiSKPvTSWAE3ArqVvPG6qetYB5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7847
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> This patchset provides RAS logging for CXL root ports, CXL downstream
> switch ports, and CXL upstream switch ports. This includes changes to
> use a portdrv notifier chain to communicate CXL AER/RAS errors to a
> cxl_pci callback.
> 
> The first 3 patches prepare for and add an atomic notifier chain to the
> portdrv driver. The portdrv's notifier chain reports the port device's
> AER internal errors to the registered callback(s). The preparation changes
> include a portdrv update to call the uncorrectable handler for PCIe root
> ports and PCIe downstream switch ports. Also, the AER correctable error
> (CE) status is made available to the AER CE handler.
> 
> The next 4 patches are in preparation for adding an atomic notification
> callback in the cxl_pci driver. This is for receiving AER internal error
> events from the portdrv notifier chain. Preparation includes adding RAS
> register block mapping, adding trace functions for logging, and
> refactoring cxl_pci RAS functions for reuse.
> 
> The final 2 patches enable the AER internal error interrupts.
[..] 
> 
> Solutions Considered (1-4):
>   Below are solutions that were considered. Solution #4 is
>   implemented in this patchset. 
[..]
>  2.) Update the AER driver to call cxl_pci driver's error handler before
>  calling pci_aer_handle_error()
>
>  This is similar to the existing RCH port error approach in aer.c.
>  In this solution the AER driver searches for a downstream CXL endpoint
>  to 'handle' detected CXL port protocol errors.
>
>  This is a good solution to consider if the one presented in this patchset
>  is not acceptable. I was initially reluctant to this approach because it
>  adds more CXL coupling to the AER driver. But, I think this solution
>  would technically work. I believe Ming was working towards this
>  solution.

I feel like the coupling is warranted because these things *are* PCIe
and CXL ports, but it means solving the interrupt distribution problem.

>   3.) Refactor portdrv
>   The portdrv refactoring solution is to change the portdrv service drivers
>   into PCIe auxiliary drivers. With this change the facility drivers can be
>   associated with a PCIe driver instead fixed bound to the portdrv driver.
> 
>   In this case the CXL port functionality would be added either as a CXL
>   auxiliary driver or as a CXL specific port driver
>   (PCI_CLASS_BRIDGE_PCI_NORMAL).
> 
>   This solution has challenges in the interrupt allocation by separate
>   auxiliary drivers and in binding of a specific driver. Binding is
>   currently based on PCIe class and would require extending the binding
>   logic to support multiple drivers for the same class.
> 
>   Jonathan Cameron is working towards this solution by initially solving
>   for the PMU service driver.[1] It is using the auxiliary bus to associate
>   what were service drivers with the portdrv driver. Using a CXL auxiliary
>   for handling CXL port RAS errors would result in RAS logic called from
>   the cxl_pci and CXL auxiliary drivers. This may need a library driver.

I don't think auxiliary bus is a fundamental step forward from pcie
portdrv, it's just a s/pcie_port_bus_type/auxiliary_bus_type/ rename,
but with all the same problems around how to distribute interrupt
services to different interested parties.

So I think notifiers are interesting from the perspective of a software
hack to enable interrupt distribution. However, given that dynamic MSI-X
support is within reach I am interested in exploring that path and
mandating that archs that want to handle CXL protocol errors natively
need to enable dynamic MSI-X. Otherwise, those platforms should disclaim
native protocol error handling support via CXL _OSC.

In other words, I expect native dynamic MSI-X support is more
maintainable in the sense of keeping all the code in one notification
domain.

>   4.) Using a portdrv notifier chain/callback for CIE/UIE
>   (Implemented in this patchset)
> 
>   This solution uses a portdrv atomic chain notifier and a cxl_pci
>   callback to handle and log CXL port RAS errors.

Oh, I will need to look that the cxl_pci tie in for this, I was
expecting cxl_pci only gets involved in the RCH case because the port
and the endpoint are one in the same object. in the VH case I would only
expect cxl_pci to get involved for its own observed protocol errors, not
those reported upstream from that endpoint.

>   I chose this after trying solution#1 above. I see a couple advantages to
>   this solution are:
>   - Is general port implementation for CIE/UIE specific handling mentioned
>   in the PCIe spec.[2]
>   - Notifier is used in RAS MCE driver as an existing example.
>   - Does not introduce further CXL dependencies into the AER driver.
>   - The notifier chain provides registration/unregistration and
>   synchronization.
> 
>   A disadvantage of this approach is coupling still exists between the CXL
>   port's driver (portdrv) and the cxl_pci driver. The CXL port device's RAS
>   is handled by a notifier callback in the cxl_pci endpoint driver.
> 
>   Most of the patches in this patchset could be reused to work with
>   solution#3 or solution#2. The atomic notifier could be dropped and
>   instead use an auxiliary device or AER driver awareness. The other
>   changes in this patchset could possibly be reused.

I appreciate the discussion of tradeoffs, thanks Terry!
