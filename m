Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA482C681
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 19:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsE/933S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704397985; x=1735933985;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n+8bg0e9rX0xTFO+wtTNMRF/3RjMjYzjKZ11SiGfhUA=;
  b=UsE/933S3ZKTF5kD3LlwlkV51F7kaydrzfYjmN+f4pma2lnqXPwplL+J
   Kp2yHkpDEMGvEug+8ainYoLIlvYjwRhqwvj1Dg5szr0eVIPQH7p6shIL5
   asO55lPiRlylwse5lqcNrJzUwoX3Wx+KmPTlmg5zlUiJVIx6kELAJNC/u
   p0gWoch1eABQVKlZxm1zmvVhwGkHulW5hIS3ISKqmcBaLQnKmXofmca4o
   jjcbUJgK9inPiUHVRyZsMmphl4Sgr6mBXdAqWum2XG7wXbixBxxvt3hTO
   3eWCSf3EdFjQ+EgflAiBBgnsohxlahdvnyUXRVhp00EBDDxCiSXqbdm9s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="394525091"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="394525091"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 11:53:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="22274592"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 11:53:02 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 11:53:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 11:53:02 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 11:53:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2iBBSuwX6N3KE/U/hh8fU/7tiz0Mo5P/WMU26NQ+Vy+6BCc9BJgrZv69pmRhwWdEz9xhiqbBKeCRuowfMshmX6urQ60RJhRTVkupRhxdNXalXV3r1KYf7Dt60JXiPo/sUqGIH3IvUvugbj0WfFNwaF86vFXmdpjWbPiUI3YFW5x8+Mxk5aZzMrhMxCiES3deqcvqN6MhFusheRjEnwX0VQIg+9zOKPRgw8H7r61WOrSBA786BV/XFbSFtx+GchFmLVfs6TVkE+wctvQmQ+heAmDIDymqM1KOkyGgDixfhRkN0Ji8tTgGaTjv/7r+ku+VqOaV/rEwT9AeTs301C6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azWTAefYqpcsahY3DkZ2Wxp8CtYzJANiIGm8om3zv1w=;
 b=RRI04e34Xcw8Rxemf0W5N5UwDYQ0kdO/NJQkYd76Qs1EPUrNAX5RlSNTXEK0eONJ6Ul5qaF94Rw4Gk3/iRkQ1iNbMpYPaf3BQ0gVC/E7feMsESj1/f6kLhVhK4GOayFZHOHdnGjsZVJaN/JHfinf5REQuz+wb6WjhFrWfiu8APWz4AO3J4eyoszO+7eGkm82B+ORWdODqTJ6hyhvfeZKAJk7fgel73JMoTER0KyaZESpWlNd7vF1rxUS7BWRJ9N73D5f0vqTUBTy6XiN0Q4OmkJR1QHxwRGoUORxVhjo6tV32kMZCd2HInWYZQ+d9WJ4irwpFp1IyJovpZ3Qb5Iy3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB8233.namprd11.prod.outlook.com (2603:10b6:610:183::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 19:52:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 19:52:58 +0000
Date: Thu, 4 Jan 2024 11:52:55 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: Robert Richter <rrichter@amd.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>
Subject: RE: [PATCH] cxl: Clarify root_port cleanup routine for
 cxl_qos_class_verify()
Message-ID: <65970c97b2b6c_8dc68294ca@dwillia2-xfh.jf.intel.com.notmuch>
References: <170438448564.3436708.17525645430052031684.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170438448564.3436708.17525645430052031684.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:303:2b::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 6169edd1-5005-437d-bb1f-08dc0d5ec067
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: meczcy+EohZvIz3ZiOLsqk3NmBza0qNts8JxpvG3EsLjw6KkjyoeoO6jnZn8L5KErDEbzeQoQ/f6i5vGYK3juMkKHPBIr6HNSLaeIgqNKfm3mA/3UvWNaDeits7esZU744HkqS8iOd1zBaEmm9B0hXHUULQmwj9+jZ7YIIsU9Ewdjgp+kKtpcE/zT29BVFc/luJ+H8HgFnQ0VZtwbuY7vrv4ay73HugGjxEOzOklMpCmO3V5zNiLkWOR+NWvSDpxRHuwZugZ72Wdgmgsm9/D8eK6QT3LrtL1GxiNsB/nd+lwpzHZpRcpimtDUOhik0Ttgf5Scz98fygUlG0QOJWZUMC6pmbjdZSVglvS+4UR0mRaS52zfBilb4d0rvu5ViAT2xIHAZ/QzHIyvAKHu89e/qVZch+9ahWWOR6KBvgSo9BzpfAn49jt0JPatcaksnsf2VE060rrKHLQpdrU4E+DCwFE7zUBWdDatFa11BuGx3Jx0xfK4+7NS8j5LBnRwG7bkPlXUyqduAXQph5TH5rvyOhiFsv1JlPoMOQ6N+s1VXs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(86362001)(82960400001)(6666004)(6506007)(6486002)(478600001)(966005)(66476007)(66556008)(316002)(66946007)(9686003)(26005)(6512007)(4326008)(5660300002)(2906002)(8676002)(8936002)(38100700002)(83380400001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AjZRkUWcQinMargC4Ux2LII8FC1YfYDipgx14dJtdvDaAgRb022OxZehwejE?=
 =?us-ascii?Q?kN9S42jx+Tuv3RtGPaGs/qadAWxGUIvMORaVzDlelJCzvpeOptUaLgumNvKg?=
 =?us-ascii?Q?TRYej4r1sn05LVLihe99DP26WpHubbcSZTpyMTvDkIuulRD6TvcRxb2WpaJE?=
 =?us-ascii?Q?lvriVYf2fm0BEXmNE8FHlYu44MYO84R/4e898WQ50DBnJJBO4QbNdkT25KZ+?=
 =?us-ascii?Q?fKRT31S6QXWHh3nHVJH44XUunUgFUa+3OBHejTClDt7jsijGweBwtMusJb1Z?=
 =?us-ascii?Q?MrzP2BaZqJcOEgwY63D63T+ce0GqR6C5Uu1r28qs8LoYojazye8NUTcpGRGW?=
 =?us-ascii?Q?/LWbU2IigN9lPXNK+GkVVF1PQAZAXEuynjrcU0o8GXEhNzygdrTKCZ1vwDMa?=
 =?us-ascii?Q?xTIY2wDdQdgH4GXlECvZk44ExfkD7A9r2oTa0LUZoE/6D0kzOvmSdT+xT9MD?=
 =?us-ascii?Q?ZN23pdyp5kgS/FHxU2oYszY+i5II5ukLn1orOLxUP0lcOo8h/DukJUV71+T4?=
 =?us-ascii?Q?ghu64uGNIvBHaYUW/4E5vJqQs47gGy5K9VZCI6XYJyJTtkD91NaP5b5C/oLp?=
 =?us-ascii?Q?alBEROpo/dRWUC2jhmQd7+pp80T8haTUwAfunOayLg5iAnUsPQEzpPjbkDoD?=
 =?us-ascii?Q?qraRnKbHj80QVHdEtXoxjKy3qT6BoEQ0bRPvX/7E1X0x/XBwIKyRWiN/69iL?=
 =?us-ascii?Q?h7G+r6htCCoe3sx5DNI4gSyUphuF5lfZhgfzX5HvwKEPbwHOu/pmWNAg10yU?=
 =?us-ascii?Q?0Grlg7wNkEEiET7z6XINURO3xQlCbtK/6NE5HImX45p/aM8txTlDdxfQgija?=
 =?us-ascii?Q?1i5uuC85IPOgX6e9fQx1BXVvfL0LA8zuJI+bFph1p5C/w2x1g2Zhsb0hVQw3?=
 =?us-ascii?Q?BRpMJeepv1oJV80fnSxyjHQAalMik+99RpiM8y35KEu6nVfMgCucl+r37TGd?=
 =?us-ascii?Q?3uQ0wu8tCuaC1uc2lh2eAb+Qum+LcO0jl7thpWwJZW5n9YMm9Qr7vjj+Ewqz?=
 =?us-ascii?Q?5/497U2N6swQFwsokgtWR58CPpztFhykW7NLeAlyI5WPAHRjYb5ZLOJjUmPz?=
 =?us-ascii?Q?M9BuwFeZF3rpZvYsFlLFyJd35U7pfCh/bbT93wE08z9XSLp3g4opbZ70ccdu?=
 =?us-ascii?Q?AQLE1Khhap3mvjO9617u2xo5FIwfkmMl/oewOl8Zcv/haq7UJdeapXqANadB?=
 =?us-ascii?Q?TTGcqPv+ou48t1rC5uOL739h0G+oegXrgIUXlyow6FlEPtKkJXFsdxXK7V3X?=
 =?us-ascii?Q?AhQA6KitzksnegtfTa0fjGkEPseuBfiKDA5qv5k7obp3zJjXi8npj7kj1EPo?=
 =?us-ascii?Q?o+WJYVQyrzgY4FDFbkXOA4dvN3M4FgoKUIdVGzJJEttmQl13LX3S0bnQSZ+N?=
 =?us-ascii?Q?6Vdxq23sG39+CUoCbIBk/KNv1LfAgrxjys83DfUKnMH7SYZz41DZrPRo8d5V?=
 =?us-ascii?Q?sxAnBiARNt1/CWu+O7lSih2AlW43IgM0+2JPfNt98wO8hr9zdxt8MuVgdAIT?=
 =?us-ascii?Q?JtPa+tN/VJV5nnRefB+18+rxbxlk7UBCm7gzhmL3NdEZ0DAPV1+sv82FHqiO?=
 =?us-ascii?Q?BOqBqxieUmjMpd5M0jXCUTm3ZeD7wow9QlOnv4KJJ2eeTiyADlD2uAhUGMUJ?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6169edd1-5005-437d-bb1f-08dc0d5ec067
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 19:52:58.7267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFGq/I1qKBfv/cFuJYS2QmfGTVTx+wnR3cYXwcPtj5WU7LwA5ZqUbXzj9URV3nTwRobiP871tn1z0TkD/4W8KGdSxjE9M5ul2Vv236qFd6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8233
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> The current __free() call for root_port in cxl_qos_class_verify() depends
> on 'struct device' to be the first member of 'struct cxl_port' and calls
> put_device() directly with the root_port pointer passed in. Add a helper
> function put_cxl_port() to handle the put_device() properly and avoid
> future issues if the 'struct device' member moves.
> 
> Suggested-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/cdat.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index cd84d87f597a..d6e64570032f 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -345,11 +345,21 @@ static void discard_dpa_perf(struct list_head *list)
>  }
>  DEFINE_FREE(dpa_perf, struct list_head *, if (!list_empty(_T)) discard_dpa_perf(_T))
>  
> +static void put_cxl_port(struct cxl_port *port)
> +{
> +	if (!port)
> +		return;
> +
> +	put_device(&port->dev);
> +}
> +
> +DEFINE_FREE(cxl_port, struct cxl_port *, put_cxl_port(_T))

I don't think there are other cases where a port reference is acquired
at runtime, so this should be root specific, i.e. put_cxl_root().

This also merits a NULL check to skip calling put_cxl_root() if the
pointer is already NULL:

	DEFINE_FREE(put_cxl_root, struct cxl_port *, if (_T) put_cxl_root(_T))

...for example if someone used no_free_ptr() to return the found root
port.

> +
>  static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	struct cxl_port *root_port __free(put_device) = NULL;
> +	struct cxl_port *root_port __free(cxl_port) = NULL;
>  	LIST_HEAD(__discard);
>  	struct list_head *discard __free(dpa_perf) = &__discard;
>  	int rc;

So in the discussion here:

http://lore.kernel.org/r/65970003ee9ef_8dc6829412@dwillia2-xfh.jf.intel.com.notmuch

...I made the assertion that if a function has multiple __free()
invocations it should make sure to arrange for it to be impossible for
declaration-order to be different from initialization order, and that
means getting rid of the "__free(x) = NULL" pattern and keep
declare/init aligned:

	struct cxl_port *root __free(put_cxl_root) = find_cxl_root(port);
