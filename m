Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64931367
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jan 2025 02:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737772570; cv=fail; b=WU/OejpLzc0jwqTzHoJKjR1a7z0vK4DxDOB+b774xkt3hwel1QsMZ9nq8sLfvURJtUqU+49ypPEpaWLvrIWRMuAJkj4rFgFmb8MtrLRax0L1OhMq1bNdLSQI1f+qD7e4LWnoaFDvbjjJ2wo9YbmHnJcygC6uVvbwOk35M+6BxfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737772570; c=relaxed/simple;
	bh=PjkOLPXDYjIIpj6a3d5eCrr/8kBjlxlFJus3rO/ry7g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Whutx88VD1tDcL7QdCoTlTjjtvbtNmvzFRAMRNDWF7Cv4qBKsH6ySPyl6Qgew/7Mxq+mrHwWHnSyt2mXwpvvTw1jRO2CDZYhyfHLtxXZDS8M+XlrEkYpRbzr1PqZbL+YMLED9pCAjrhSigkjCJZ8prLgUeg+qSarR/h7BHijF/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ou0ueFO4; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ou0ueFO4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737772569; x=1769308569;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PjkOLPXDYjIIpj6a3d5eCrr/8kBjlxlFJus3rO/ry7g=;
  b=Ou0ueFO42jRMewSeS0IigDW6ZpnzZN84JTQ6BtKhgqkBcZbYM+j9eYwz
   mOd5o5AqTQRk2ErNbhv9L6eZfFyJd4dLGGmYZwgNKv3KoXxt1HM2d75Zh
   INSZ7BM93eIC5o29KrUbF04SHmy1PNVf8tNd2abnYiL8QSEklQxpV/d8g
   1N8GpzjaXnBuf2xD5lZKCAgcoQOYTKf9NOhOkXnLcUnddQPaTJSilyRP6
   sy8lcEUtR+jPRmPQB/W07kA3hlIcF4CJJwLZyHcdHKW79PA+uQH8ewtsY
   r/jyIy05b2hTFxcTa9g/xOy8xadYZZ7VxMX011M/WAus0BaiBPD5io0Ok
   Q==;
X-CSE-ConnectionGUID: EP+qRefpQxycK833iUvR+g==
X-CSE-MsgGUID: /vy72JFTTPqXN7osfpaHag==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="49733777"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="49733777"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 18:36:08 -0800
X-CSE-ConnectionGUID: xQc0O0leQq+Ctbq954YRQw==
X-CSE-MsgGUID: 2QvCMORqS12+5lm7bPUauw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111956846"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 18:36:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 18:36:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 18:36:07 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 18:36:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cxk/yT+vpQZ9VZwbn5qnOA7bvNp+AmiUjvAMjU3SPug73aYBq9fkK6ZAzxcdRRIHOt1koStCjNKqv6kXpUb/q6GV2HZesPyx/B19nPYfCG7ufHGOy+ydxlOB9YzxL/BLECfJCKCYhNzZ122flCQI0GM6yrvmiDf+8IBRBpTc76qhStry9UgniAfp5x+dlPlhA9WMY3tI5Yk0plFBgiRt33yLGA7/dwpo4G+mvpwOV6EuqDC3NvCB/GtpbnqnrXziWNSZSMvC1wyPJ63uozkCr/QUnBk+h1YQhF7AD1G7DB03Vm+maKfVXFHNSkcTakRqJ1eps9VplKyg4d6PhMY2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVtBqgqzAtWQFd46a6382g023euiHfssOkrklyayycw=;
 b=w/nweH3fRImGBKiHJtZV7nFrVn48f0n/gDng3ICHB2W7Ld8m83WMkswc0rq8BZmtS0Jf2I3cpsMfzm7TiHZcugxIoMKhSYnfrPinnOELoTUEcD+bg4R+fl6rVzgAtU4/ED6pmSVBVTmJNbNodo7yOSoghJ0rznDz3EWkch8Mf8ti9BqY5RNV/e6msnb98NQ7ObXQGHTgB1ZZZZTw0EJgSDXVpeQrwX9b5J7obnyu1u3Xg/5C+rYJ86cbI33uKVkG1JASgFZZb/lJDifzHZlDjKxfAV78da2e4xJknOihVc2ZwhXc1Xct1kgIRn4stXc9LNTgYU8n+J/ANIb0KDcxUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PR11MB8716.namprd11.prod.outlook.com (2603:10b6:0:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Sat, 25 Jan
 2025 02:36:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Sat, 25 Jan 2025
 02:36:05 +0000
Date: Fri, 24 Jan 2025 18:36:03 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 18/19] cxl/test: Add Set Feature support to cxl_test
Message-ID: <67944e138c6c_20fa294e8@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-19-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122235159.2716036-19-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:303:b8::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PR11MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a4a4f9-04dc-4ec1-1ab5-08dd3ce9042b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5dFKLNo4QZ3F3TbxwXMj5BL+Er5KfnN0OWFPXEmuk8I7sTh2tzUrBZOQs1+L?=
 =?us-ascii?Q?Od5EQ+f67ubJi0FsmGpa/bGlfjhteocPb+Xp7PG4ILsQKJgQB7Yz6hVH/6X+?=
 =?us-ascii?Q?TqCdvw9cNL/IkwVYL5bctWfhsLxnaoQ1iRpjKcqEkRU0I0C6nlNnThZ0VsoO?=
 =?us-ascii?Q?RfpJWcGT8KuxKaQp0RJh8S3F3zbwfOHIxhCFuI5XjOGB3GzMkDK2qkl6WWBX?=
 =?us-ascii?Q?esAMuHC+UVa4pJBd5c6gR3OXfzPVNGmeV3nD5vIY/9o5QmQXFKgG3gxFdHu4?=
 =?us-ascii?Q?l6Q4PdMxTzLlrfJidYBrqIDLVuFuJbUprBJhFn2SlJd2yq1pMudbuyvDVdyq?=
 =?us-ascii?Q?ig8kdKvKIK+lVHxUrGH6ch9ANxpRvgD7K9SGUJqJu7S5KE5mqKxeucqod0BD?=
 =?us-ascii?Q?t/VjS8DJEpP5tOfIdmrQrA6ASc4E1F4Xq9GgbHpIcEwoZGN/HEQbJWo8H+tu?=
 =?us-ascii?Q?d/Gj27BHZtPndwpJlOkUoFzX5O4klNpOtrGDyUfV9B8BQ6/VQE41w3Az35vD?=
 =?us-ascii?Q?zIgnEB18VVY1+FQDBNVoWvwrsAs8HEshsNKAk6RctNwSwdg1RkJ57GWpgmQW?=
 =?us-ascii?Q?99fgjBrCWXo4Mv61JJvYsl7vlnPzG2lY0gg2VyFOxCG5EeRZv267/LJZFrpo?=
 =?us-ascii?Q?GdL96SrlbnNGTzVOYM6P/BuMfGMZCMwsZqIQrgL9lBGI2Ha8mDvEJk9m04Ji?=
 =?us-ascii?Q?0XCmxQ96XTiYDxJRdozMLSAome0g/kS60C9GvFEIThaEuL5cHQqPp6JpULNu?=
 =?us-ascii?Q?fsFudPboFGDuqMi7Gtt8TCEL80ZQ3FxyvqWzNcPzN9cG0GL1LO9aJOVlHkJn?=
 =?us-ascii?Q?5/VOyeCb/ZUKRypi95rmt/+nJqpUsBZQccCg6APSx8f+coNuvTLjZeuDNHMS?=
 =?us-ascii?Q?Ly1ZhELJWiG/Di6cbKsoGF9jwRss9fCfsnCF184L+lS7GXyFxJUNDXI1pZLK?=
 =?us-ascii?Q?1uPiUeIS7k0YLxuMTe4W1rtM0xiROhrYKwoboP7/DtorCM0KL2TvKdOCv11a?=
 =?us-ascii?Q?PoETLJUWcshVRhzhyb048Fs10cOAspl506Bbbh/30YL/mDsfaf5rHYQFJKoC?=
 =?us-ascii?Q?5dv25Ws6YHg9ZabJnH+nVMBSoAzUGgQ8IyEbfRQlyfdCnFQIstPtn/HqxtfD?=
 =?us-ascii?Q?HRSQ0DOGE9ZOyw1rOFk7QkNpe29vPKYu1yiXEORNBZjUbbns3HfigfnzR5Bf?=
 =?us-ascii?Q?5mIalXz6aoeofEdiqoBCeLghw7ZV3Xgf6hwVow5Y2SchTen5malj8zJcdXfc?=
 =?us-ascii?Q?yfn/PYH2KWYwWQTm4jVIUWZIxmHgiBHJsnial2yTfzN1JQli7765qhfi6HfX?=
 =?us-ascii?Q?ac2Q7r2TIONI1UKId+qaPlKSj8/jDopR6VO69oHU2DJabdns1TzLHytjYfNG?=
 =?us-ascii?Q?LcRxEmFrprdHSQ2XrO7+A89fU0M5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V/7BE38lV2KoT08jw8zhKMfTEtkJ1KZlx9QAzR7VRzyGSC/6sZ6uu5Grn3a6?=
 =?us-ascii?Q?vKI1WX1Oe375nWcPxMNrrx4wR+Z9gLEaHRU/C1v8K1j71aCVnHcfs4UUmXeZ?=
 =?us-ascii?Q?AQjMeySuwmH4MGNLN93x3BZXybXVC9FL4wpdTah8bPPyw2WAv5hK/QI1uasg?=
 =?us-ascii?Q?S1p7W3ScJXeZPg+Jq9QX34p0p9k7utObvBmn5N0KS1pocgOViVIE50wcfrHf?=
 =?us-ascii?Q?zGt+df+GgYcuQSboxFVRwy862ZYVSbhprvLIVlfbdLUEXe2+gOHRj7WppiVz?=
 =?us-ascii?Q?BnxDwI5Tn86Xa+5aV+gvlxZxU2EWlEbG+Cuv3c7OFhM8d3gYW2PqSE/X+Dkd?=
 =?us-ascii?Q?ELVNqByT2PK+MSzqnGqWkWWChZtO6fcvTjA+4O4cWpT3L28n+BJB+IFsps4A?=
 =?us-ascii?Q?O7ALjuH6fgClyLfF4cQZt5TeC1zQm7TT0b3XljV67odM+MlMdFe2Iv2o1+Ej?=
 =?us-ascii?Q?p9Lm0NRxyGx8AoT+6ihLAEpqTweS4xVbv86psm4f4v43Q2GVfPJkUONsVTna?=
 =?us-ascii?Q?F1mb5RJQ8SNGPpaxFfC9hwWFhIXzVyyc43XihnvsaRCf+4uMfCLoqaiKrLEb?=
 =?us-ascii?Q?rXggWQI3hzV6GwzGzZVdNsH2WljOVV5+B/ABljhsihrBlEngElmSkKjt6VdX?=
 =?us-ascii?Q?HNFgpDt7kAVUqNQQvhB0Q9REO2nMvJwk80S/4UgLHpJuUM1vHBOkBarrvMtx?=
 =?us-ascii?Q?fH/+bqkvLJ7CJDsyBTLjST9ApC3B66fIPGIFn1H1k8bwucnbQe/tZnLWZeK3?=
 =?us-ascii?Q?ZxX0x0rR42xKy81Yd5nFJ88BoYfG9V4VGEp12We7JFfr9g0s/ri0Ud68cBgt?=
 =?us-ascii?Q?GQ04sWDWvE/bO1uelLFKrZvujx9WoRhG/q/BA6FUQQr6AxUS+tL7VgUB4HPh?=
 =?us-ascii?Q?juTGMEXPSOz/++fu7Je2StlZxPmuLcfMBM7x2uoNs30vnp0TbbsoNk6XsRcm?=
 =?us-ascii?Q?qc6t2YVEPiGoa91L067Q++cgvixMs9n0M+3WKdsvLL7bctScF6QqRT5H7LAU?=
 =?us-ascii?Q?EDoBFv7+4PbApad4jHl8DNOYe1h0En+GEImo00qQ0zN5Dyj5XWB4fD9YiYGd?=
 =?us-ascii?Q?LmKwkg0YdQxvY6GRo37UTY5mW9sGPLV37ZyZ3eOwCc7vzzFOZkXvmLrXTUIn?=
 =?us-ascii?Q?j1TK2lOwx9v8/PTeD6xENXH0jr22m1e50csD6jhCwjj8F07o4Dsd6XNee4gw?=
 =?us-ascii?Q?9T1M1HQboBptAegOS+AbLAXmvt1G260eLVIwGDlAqyFL316TkTlYqo+XW+s7?=
 =?us-ascii?Q?EUkapPjLSCmLH/Eu78AEP53SDy99DHJB8pWRM5+VkI4pKDWI1VDgOznfi5p/?=
 =?us-ascii?Q?SrdPx/PdhueKwodE6coKUmuNeJOuNZZ+YMY7zYSOPMM6cAzqoIGOZC3Vf8lN?=
 =?us-ascii?Q?GLKyrjdtBG29ec3y58ks+I79FmO3CNF2FEO+9SCzh2CkuJCItBwKDTO5anyH?=
 =?us-ascii?Q?tj+vhlu7iqKV0cRsLcErsk6UmmoSDLvoHLjoEGZBJfJx3oYqKQPbcgfZxXzg?=
 =?us-ascii?Q?bFLhcw9IZz/+ehufKswNLNZmUZ+kLfBI2acv5s1pA3UeCEWnzOPHGjQba0bK?=
 =?us-ascii?Q?/dN4Ax5gKNICZKDTmFp38sdF9zX1FRlL5Co3oOzJ3v5j/aYFVk05ND2/1zsE?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a4a4f9-04dc-4ec1-1ab5-08dd3ce9042b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 02:36:05.2702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DLkAr5wnQoSni0b1lmKvB7P65zGK/NDymD9r3uO+GlaE8XZUsEcMYsL9YMVD5h8J/ry4fYV8X+20/kARBmD681OYL/Nn0HDLd7T8jR/P3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8716
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add emulation to support Set Feature mailbox command to cxl_test.
> The only feature supported is the device patrol scrub feature. The
> set feature allows activation of patrol scrub for the cxl_test
> emulated device. The command does not support partial data transfer
> even though the spec allows it. This restriction is to reduce complexity
> of the emulation given the patrol scrub feature is very minimal.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

For cxl-test it does not need to be a real spec feature, it can just be
a scratch pad like Feature with a made up UUID and effects.

Again, future work, for this one:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
