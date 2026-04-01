Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861422AE68
	for <linux-cxl@vger.kernel.org>; Wed,  1 Apr 2026 00:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003206; cv=fail; b=suAgLndqLz33WDwOcc/F6IISBwMjM4TQ6KnyKxcPeG0VLmY0AB7HSmsysY5qEp67/GLs8AthNo70sJuZggPmvOvjGFbiL5a1RBBzlg8Y8Mji9MZzy9f8ChOrNCb0ocvzyodUNAXboQLpnv388IHv4Vvu+7uvCC7aPGuLe7xx+p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003206; c=relaxed/simple;
	bh=lRV3UgmN22aR0HL6qeQa7bDzPChzDED4q2tmtPWaYIc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=da4+h8pjKiXzQqZvbwn87kTPTy3RSXdGgI+/9iT2sKER6qtBDbTFrPiSm8olcchCSUMiNccnzf1x7qBneP9ZK4iYRcsyKsRCipyPcmALTzyUSU9dJSg/Cdj8CwWD2KlB04apkNJMtX87GQAlnv3Rsl1UlkLgCKxjLPLi8WXupik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RvrySOdF; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvrySOdF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775003205; x=1806539205;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lRV3UgmN22aR0HL6qeQa7bDzPChzDED4q2tmtPWaYIc=;
  b=RvrySOdF154jgP8C5wCrzIPFrVH4/JPWoVBqVLfZHs96MUQb3B37wQou
   zsHVdVS/l2cr25GoILAuKIMVx/rc7zPSX9TsUQ89380F7QYD9B79qXr0L
   9eEwl3t5+ldLYkjIgsn82cKP5EsR4I/77UnQW1VD7RMztz0RTk6Ob5WF8
   HjDAugcHK7n7zu4oVVEr9esKCqlPiHZi4U8veGbT7sMOot3KjroE6oUNg
   zNGEI0AwHjdDeJ+Wpvn3iNtzdvpeZT1HJx4exjCMLYVFWcn3K8XXqUk/s
   Qd792mi0W+PQ7cDl8EU7ESrLCz6rQ9rbW4uc/FHSmtuQtyI7rTZjAkQS5
   w==;
X-CSE-ConnectionGUID: jMTrsGd6SZCm6IIo+rUaTA==
X-CSE-MsgGUID: JiPGYwj7RwuGLnwAE6svbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87108078"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="87108078"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 17:26:45 -0700
X-CSE-ConnectionGUID: 6CQYJRYGTeK14hEGGNicFg==
X-CSE-MsgGUID: X2CCg7rSSseX1bzjfTtcrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="230582007"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 17:26:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 17:26:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 17:26:43 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.49) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 17:26:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDWpwxTCtKTO8y+II49RLUVTU94WZq6+id/y80Z44BVDjt8SxlEgx9HLRYG9nEoyBn6lo0UpQa7q+Mk4OsJf6EPAul3YLB/hK6jlhqfmaqMePZLEF9wZLSZsSdilMzoHgX9GPXDpEcM92mnhjybCEGQ+kGmUT/p3+I3hVkqTyLSnGmc4W3HdVa078KJBBp7LRmk5DLNmTxjyEYF8vrzyCyppZgAHz24r7+lQJXH8oMyLPv4gd8OjCDbO4lNgUmn/+UNY/B3GGre8QKsmANoD1xS3QPN4+5sTe1QtAvfbP02S6TIXKbD2ohRghctpRJ1LHZ7hj1AqBoMHxFkndB8aEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TPIVVvjH6MT3MvTLzuBswSZ2rO71BV24zv/reSF7xI=;
 b=JVfa11E2m4WzTeXXzPi04cw61w90xAcZlarNKGYZj3vXjFQKqVfr9PRd1oqtevIWQAxdTNhPTtouCJr84FzppQfV5UthM6wp3PrmpU9Hv47WQd2Z4eMSBxu8Z5TVF0LTEYiXc7kZiL9tLZtuJx3Qkmdr4Vvbkid3/gES0rYOJFzyU1ZUa7D/ZAGRGxnAbZoPZofHyMaRD6VqImhoTkKX+LXUk6ZCEf0VImQntqOHhfQDVRNzwqZvJHnwPAnIv8TArJ+MA3m5pwMIkKEYlcI/WF5q/1oFFzb6yWmSRNF/Kk6IGzoP0ojifYCV1JG2hZVj7Cec8IL/NAOx0wso1ul+7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS3PR11MB9671.namprd11.prod.outlook.com (2603:10b6:8:38e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 00:26:36 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 00:26:36 +0000
Date: Tue, 31 Mar 2026 17:26:32 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/1] ndctl: Show region locked status to user
Message-ID: <acxmON1VSw4EEp4q@aschofie-mobl2.lan>
References: <20260329144714.888155-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260329144714.888155-1-ming.li@zohomail.com>
X-ClientProxiedBy: BY3PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:a03:255::25) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS3PR11MB9671:EE_
X-MS-Office365-Filtering-Correlation-Id: c71f482f-9759-4318-fd18-08de8f8555d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +H671YDbHsFVRvGh4TXBWJz4gnUdEx/xSv/EYlBsauJHPtrQ3ZlZEyWTIjLRPpq6a46InSCoIRy7EqLHG0jHm7apNATQjv2n3EK1wwZ7ytvAm4Up1hhbejqjoQuAyxjFf3KnEz/JrXWwtk8FwK6buL2jkwiaIbyOwpACWwKvzQh7U5sid8o4TzMM++Ve2O51s8e/HkqSdmvzwmWO/e5eYw/Dy7Enfx4s0KF7QEp+YXOh/LWESydfDyI4q0L1orh/hvtIgh7Lk1k3Pw4wCZ4lpDdM4nkOguozBJS7FWKZguAyCiN9Yc9NcPIdnJ40xb+q+d9l9Ix2G7dlWUi9UgLigyqq/6eId9FSyI9qOqcj50xas3PDPn3duUgdY5xfgmjw+ljM/O6oNgb+6M/bYZ5XJFeZvO7n+FiCr5SqKQKb0TTIxjDi0Qe6q5IXKOF1BLrWBJa/RVcGJxThxol1vPohL4RXitkK9PL3LJ4z+AKDydacEplyztLTndknZdimBeyvhRahEozA8UfhymlK/wNOLq149WL/jP+RnbpIhwcwstPeMKySa6BnG2ysEx5I82CxbtpvVLqRer6iU1T8fDh/ke1Ig/PNU8UhOl7uGPLICoi6/wiCZvYp/flGkPCMQtrfFrR2l0KR7GqGnyGo70EE9HRuU2R743rzPNLooAcAFGLiyxiy4Cx4fnEuanxJV7Q4OV4/UH7HsYFFJoy9zKum7XgTVrtfE0S362vdWp4nlDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fMIEtarFTgNkLGpIcxoNiI/Qp3cgqkD6RuS0H6i8q1iWT/aDip2PR7q08eOQ?=
 =?us-ascii?Q?qJsqIA6CwOXA2XMmxJdaoRmZqtZN4F9qHAe4wOOwaN49kXNNyMY9ERuB3IGH?=
 =?us-ascii?Q?diMb9+WzlFbU8AiCrz/egPX5n5a7FaF6QouUAAu0Uvg1RR00eQjK/Fa7n3w3?=
 =?us-ascii?Q?LPEirVkf08J7ec1rIObxwz7A7KxA1E2eYz0rRehqsf/s6xA13Jra/aAIZBSj?=
 =?us-ascii?Q?Dog2jCuzN0F1tWQkrgC5vL/uMVdYVqNQKfEeiesURr6hAoIu6qTNdoKgFE5u?=
 =?us-ascii?Q?L5AiBmod2sv5n+f9wsML7UQDK1c0bDEexvVqvKnpvEn+PKDoWkCtL6tA+2AV?=
 =?us-ascii?Q?HHjBa7/bpQNRkOUxogRn0eNEcce0Ju4abYm2u9Kcbs1S5aPfL3Y62sdS/PEd?=
 =?us-ascii?Q?Z39Jp3Xt95CwK4rMHwLs4y8qkIOdJIXTvyLWVNQVzwykrxGAk0f1//KTTbiZ?=
 =?us-ascii?Q?Gm4QudoPGH0GsSakdXX/IxcrrQedYBmbY3gzAVNHUhT30bJda9Tzd1jaP7MR?=
 =?us-ascii?Q?SKZ9wgU5XZcdPZ7FqArH+DbNrXLgg5mcD8+wdGRH44WvEQPEi8rTKjPlomoJ?=
 =?us-ascii?Q?d7Ga7GzUmSeMQModeYl5BdAx4ydU9GtlcqClYedtK+iQsyBY7fWAP7glwMQE?=
 =?us-ascii?Q?TwXuj8XKDk8cKhk8U3dVrPfVwBlinGmPyH9n1ZlMlKTDU6QCxlb3Z/mjW+QO?=
 =?us-ascii?Q?QsgSZd9Viwqr9Usg3Dpm9zt5qqWdHNAyY1+01jfEVfkJY0ygnAS1Kfahrm8q?=
 =?us-ascii?Q?KizJDM45cdbv7dLt3gsUH78um+B4aHkmwA3Qe6ZF9F+WfqfbxXmFBXN6LPuI?=
 =?us-ascii?Q?Ri6g8E2y81skf7CXGGw1pz/y04oy+VySYgA/tGOpjYAQ8O9xeOlUtQAn3fqu?=
 =?us-ascii?Q?x15wJ4+2Q/94MsxrjwchZW04P/PylWyxzBw1HHKmkt6AubhvWxGCBQxV/XDg?=
 =?us-ascii?Q?qPcAkDxbCnwFPS6SwioLeMa+W7DIjHyXJdna8tCpTUUCe8StdgXwUfqlzZZP?=
 =?us-ascii?Q?04HvVO9gWph/Xkb0a5pp6SPdRlxF92ybpb0QpLcY7L6diANLj1BEtm+S4G6o?=
 =?us-ascii?Q?mt2TEWW2Q5G7szG1Id2OuuVQzJ8fe/3OeApdtdOdRdhON3htz18R4J1Y3Slr?=
 =?us-ascii?Q?Ti1iTkcGNPKy9vKWIKOqzC2xuQn57gOxjIbJm4XtJ/LCbKcnuUTyH4b5V7hP?=
 =?us-ascii?Q?oZwCGs0EV2abbK41te+xJY2uP0DHBV6ZR9grcCq8w8WS94YZUxqRRDaYlcrp?=
 =?us-ascii?Q?aRpB14gt7W7o+dIcf2glHeSrSY7TSFTFbFqXno3Ex01LPgeVpKCYWXep+P9+?=
 =?us-ascii?Q?6RmvvIJpWlzn8rDfviUuKi4Z+Y1NZelv4yDks8c3PdwnetpFIp1WvY+kvPUE?=
 =?us-ascii?Q?t6Ph6/wXAF/zXuPfkp8DYfFWWKUPsqPvcCGdiVKemPJrxsgCePjukFtxF7oZ?=
 =?us-ascii?Q?HNu6CwRFgDVSHgujps8EuJ1PVKZJpzNltcUrYyBwp0H318fpi6Nna1lO7JJB?=
 =?us-ascii?Q?roBwptdicRbK8fKrJwF1YjDuGajvKGdH5Q86w15bUdG2/H2bhb6GiFu26lmM?=
 =?us-ascii?Q?vxl9qRj5tK31tfH8dc60lLMeYIGSAtuPz/N+wZ1Jug0GSFaLMO3NLd49GY/L?=
 =?us-ascii?Q?VJY9PfnkUs7y1aaL/0nrZ4x12eCUdr3Lm0bFXezfLy9VoCGzSNoD5gHsVLcs?=
 =?us-ascii?Q?IA7I0iBRG2TRwpiyGnwWX/57eC2/NIaWJQzYrMTFn565AjYwSiSAiYXWL+KF?=
 =?us-ascii?Q?LPIQGeRdDVWV9dr7ET7BWBsbcSYXRs4=3D?=
X-Exchange-RoutingPolicyChecked: vZm33/g9U86RkzaWEg3dZsHmFhYBodJFu9MFB8T7Pu+udO1JNammJ8dlr/zXPXna9JakoxpcBbsqTruos6aTwSx+XlC4cg7cuzjfAKBzCjI/orSA5xnIayxYQOCQ2PO81Wt14iqH8xDVxwoQvQ4ANbKApzwtC1IfdusIkbvodnvnoAWD7i+qbL0Xoc0jrJyrxeLXQg+H0wAEbf1nRS8spGoVX6vZEHU5iw8HOIkoil+U73Z1u+LqApbiS8/M1nA2sE6FHHSvrk1hssGLfbW9MkZyBe4qJtj1CtO548MXscMr6kGQo6jK3SUfISqNbVTzIVzorANKNLvCqyMpTCp94w==
X-MS-Exchange-CrossTenant-Network-Message-Id: c71f482f-9759-4318-fd18-08de8f8555d6
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 00:26:36.7785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZ4z4oerryshllJl43UiauPOnbtE+T/iWJIfIM2Iy2V7ZBvi4ojx4Rm27qm2daPCmk2aVxgO7kPpiv5eMW4MPmWSJcepBFzqRDPGau3oiyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9671
X-OriginatorOrg: intel.com

On Sun, Mar 29, 2026 at 10:47:14PM +0800, Li Ming wrote:
> A region is not allowed to be destroyed if it is in locked status.
> cxl destroy-region command will fail and ask user to try it again as
> root, but it is not the real reason and it will confuse user if user is
> already a root user. This patch will shows the region locked status in
> region information and outputs an explicit log to user that operation is
> not allowed like below.
> 
> Before the patch:
> cxl list -ir region0
> [
>   {
>     "region":"region0",
>     "resource":53955526656,
>     "size":536870912,
>     "type":"ram",
>     "interleave_ways":2,
>     "interleave_granularity":256,
>     "decode_state":"commit",
>     "state":"disabled",
>     "qos_class_mismatch":true
>   }
> ]
> 
> cxl destroy-region region0
> libcxl: write_attr: failed to write 0
>  to /sys/bus/cxl/devices/root0/decoder0.0/region0/commit: Operation not permitted hint: try running as root or using sudo
> cxl region: destroy_region: region0: failed to reset decode: Operation not permitted
> cxl region: decoder_region_action: region0: failed: Operation not permitted
> cxl region: region_action: one or more failures, last failure: Operation not permitted
> cxl region: cmd_destroy_region: destroyed 0 regions
> 
> After the patch:
> root@jammy-cloud:~/ndctl# cxl list -ir region0
> [
>   {
>     "region":"region0",
>     "resource":53955526656,
>     "size":536870912,
>     "type":"ram",
>     "interleave_ways":2,
>     "interleave_granularity":256,
>     "decode_state":"commit",
>     "state":"disabled",
>     "locked":true,
>     "qos_class_mismatch":true
>   }
> ]
> 
> cxl destroy-region region0
> cxl region: destroy_region: region0: Cannot destroy a locked region.
> cxl region: decoder_region_action: region0: failed: Operation not permitted
> cxl region: region_action: one or more failures, last failure: Operation not permitted
> cxl region: cmd_destroy_region: destroyed 0 regions

Nice!

> @@ -853,6 +853,12 @@ static int destroy_region(struct cxl_region *region)
>  		}
>  	}
>  
> +	if (cxl_region_is_locked(region)) {
> +		log_err(&rl, "%s: Cannot destroy a locked region.\n",
> +			devname);
> +		return -EPERM;
> +	}
> +

How about moving the check earlier, before the unbind/disable?

With this here, users selecting --force will get back a disabled
region. Seems better to do nothing at all if destroy is not an
option.

>  	/* Reset the region decode in preparation for removal */
>  	rc = cxl_region_decode_reset(region);
>  	if (rc) {
> -- 
> 2.43.0
> 
