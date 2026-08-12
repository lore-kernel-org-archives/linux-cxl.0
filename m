Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012064.outbound.protection.outlook.com [40.107.200.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0327328616
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521131; cv=fail; b=Z3+fnoTqsMTzk405cudy6i4vlxCWwHBjiTbcOiaIypp/wnOjmdBHGVFx2DXOf6GqBG7vZfk3uhjQbJdqBhe4o+aMGwUbS8S3Ff0AI3BQFfa+udoe8DEFOPNtH+dslWNjz0s8Elg7cs4KhaTWJo2Xd9/J0E7O1f1hD5l2N2rGha0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521131; c=relaxed/simple;
	bh=LpYwqFLQXUlHxmNCpZqwM+e2zIiH6ucLiZQzTnKRvFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LbIn/Romv5EtC9v8vLtLqRTl3O26znTMlm/kpdbTKQ2/GHbTTDi5zUSQeQ2cXl+wSpR+XoEIXUuHCUKUgipjsw2laYs29zhGLGnV6jJi22WJnoxHISYM/mMGKpDFrJw7ZRFx3CLQMdFjPWIFu0Fs5CWZU6C3so3DRNVux793zwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mzepcrAm; arc=fail smtp.client-ip=40.107.200.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mzepcrAm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPg/oZ8oPp5jaGZOri5poU+qucBzCLSRQe4JBHZJsLn7Xs++66tSHDwkw2B3TG8G8z09+me1S5QprSfsagJ81cvBEG9CUdig5sykUDJbEgIx4I7NVvvjcavbonLfsx/4T7ke4NBeGeO0+rFGR0T+jFAnTrFPf3yDKmz4xQqi67J2c3BLNXQWjXcMYeBuxGi/4SnX+4KpM7U72Dlyg/5MHRmAR4QG/4nBgaoJbGWA0qsjKPjydCoAZQA9BNEWEh/nqveJuXJjwYaF+1L2+krzwTjPM3fhUV3pe+cli/8rdMVuPKf4b8Pi0l57+1cIQi0iyAshLUlPWbzT85hNWhFeLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlrfpgQOVAvtotfH0kstNlgy+j14e8KNQxJH5DRwd/w=;
 b=JbFpiad8DMyLAdkMfMlgCcAb1lAt6duf25r41FNBpf/9wLG3O3+Ti6aCIYV9rB4Hx1tGTGQS8upT4Q1+dVWS1CreVoEwmLyBC1xlGUZYkz99oN4rGccNOxdlhLsqrQNxszEKfYPp0T+yHOPUg7DiHs7yw1VTbBg5ybpyTXxwIfQE/2khrdBGzE86ukJUpo19tDmuvTnAt0EMzF7ZzxRqTs9rrk7z8LwQ07SW9kBlCl7yD+L31foQQJS3CA8VrXCKs/Ab2pyN7Nk18KAc4gx1Brp60BYiek9KOBMDG60lfm5f7XZ/5ngexhINc/o7oUaf6bNks9kcDDb/c/NIoMY8QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlrfpgQOVAvtotfH0kstNlgy+j14e8KNQxJH5DRwd/w=;
 b=mzepcrAm3HTrncgUGC3Htqqik4etC6apLzH2k/UrTZ0u0OGac6vtEJ0YJGIgmqz9zQwhUaKUtBLUX1NGE4Hxbrr/Iu4tbKqNs/hz/Gh+ts3XN5eIKwetkxrhsWzpdtCtZj5DztI/8xvm6wTWCohMdoohoDNeEAEnTOYJb1J0ztp4LPoqwO33V2cAuel9l6GRipKGuZ38xMjPQzxmxVX5W5MbJoUKpUvopOVQ34xI7eleJcZx5+7iL18zaj/ePdzxxB3QLNPHu2Pl0YK0jNzXKX09lr4MDxp//ObXLOIrDbq0M0TPV+ZJIInbFJGysm5LsqyHb9HJE1HmBgoG8hL0Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 07:52:05 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 07:52:05 +0000
Date: Wed, 12 Aug 2026 15:51:57 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/core: Fix dport use-after-free via the
 einj_inject debugfs file
Message-ID: <anwlgJl8I_XhJ6dX@MWDK4CY14F>
References: <20260812060943.56246-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812060943.56246-1-kanie@linux.alibaba.com>
X-ClientProxiedBy: KU2P306CA0028.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3b::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ0PR12MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a882e6-f7f6-4798-7679-08def84699f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	azz64JEZrTTatX4uJXXdkRoAEMEiqKg5/n3tH9k1QIlgmQjFJEknpDSWhG7PYZLE1OT/YP4YgnbwLglIMzb9/HXEaXbqInDcelDUaUgqhCLurnwtYFlXoM7yv64NUPcXY0CXQwl84KMQQr5BS9w2Key8fJFUY5lc18yoc92+l/qBfl9SDg6ZVphDcJafi4Sn6gbMhrbMhtCn4wHKGmnD1Ye1VhJdrgi5gkIb/1L0TSqJ+Zldh6WkwDaVxRGQGo+XyKCfGmyV/9yJ/SFXCUkofryCdjVQxk3IkVlkNo0kSWZIuiTaq4GuR1QgdwKfH2Q+G2G/GEiO238YyqssYfSn0WozPn/3au2FrdmBAhcatdq8iLejMaCvI1dTZqQTx/BmWofMB6N9tWHSD5NYQNLhtCwWOfEjlxDsKSS0Zn2m3kzvxbdlRFbcYtknbimccxNBTQL4Wk5Iyo9hvfELnqq5N7NioLZ22pCAvfp2M/Rt1yD1epMWCJN/jM3XzHFjUmY6G+LJqYbxYVjaPE4Odf82notEh53gcWuuZMsk6N5mAcHOZk3TJbPORFPbtT2EJIQsVOMZZUhpVFXFaVoRfHPw6LZUvwttDXN19K7vyQCjhzl1JvZXGTTWK2Im38C+x09tpIlgE8BD1OpmPgog3PbDV1SOwRXMRAlLJKh1ChA8AS8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jyl7AaGBVNlz5k13O1gCzC4KRs3DyA2a2L29D1wa/qVY5RpjjJXndxhEnumg?=
 =?us-ascii?Q?tEg2jy7uVuh7h2OrGxyw6Q0AeTEHdRkih6XWy6ZVLiVPRdnbQo7SBnxCBcYw?=
 =?us-ascii?Q?+Cio7M+jUxn6QuNHK68OPpZ9JbVhcURo7MjJqyVtHJTHiN23KyQNPHQiH/Fs?=
 =?us-ascii?Q?wU0wJoIdQvWpa3O1aytqnf8yVzyQGg660flxJhyt9US0EyKwwq1P8VNinSBC?=
 =?us-ascii?Q?YlETA6pWfcsKp4fN10jXxfbXs2GFDAdjyiCqnMUQuSJ/JvDHrl/jtG82tF/8?=
 =?us-ascii?Q?SjNlnYxQuoxR4QdkqrDIdrAm3ulLdKvOH7ikpPUZuE7DkMhcGFbtoLMCRoCI?=
 =?us-ascii?Q?NJSlKpR7LGC2kB1Y5KCHkY7ZWyv0esgPob6RD9p1/mQTZQCwWJj0hs7kPiJO?=
 =?us-ascii?Q?3Y8Kwpopeus5IucSxQIvMq+O6/1x+HG0TeGNfVM4kghMGR8FHbJ1C/477qXh?=
 =?us-ascii?Q?GY20E2Sz0kDFfs+gaVQXFPxbrbCedPNwnywfls4UiIc8iaaS/k9gfDASW8At?=
 =?us-ascii?Q?g46B8kWTJROgqbCbCJGus3eLYdsfoLkjsVQN8CKZ+nhTFwgGqYHK6wJLH2Kj?=
 =?us-ascii?Q?JZXo5IJ7qar1QEc7kPp7k29cfQW9ZMFn5g4UFlvtilbpzfERaxiCUDtmslYL?=
 =?us-ascii?Q?tc4pbsuXmBQ14SnKULi3RlXFwY6XR7WtJ9qBTFtCswWCpPy9BcvObxnkHzR9?=
 =?us-ascii?Q?7LsdQ+AQpVHOGPaMOy6u1rIPNz+r2uXJFPjKOuKcBgkBlzlvgW3XolNMXwju?=
 =?us-ascii?Q?trYgrSEJ/1HBcwAbW1ZWBYJsMSJmlwJylJhRH7sy/PtuK+8s9kyYT+e32juD?=
 =?us-ascii?Q?yF7eaLVCw8YiQ3WlZiqb7IK3YAeECx1G77zr6teHyFetwX51eDhVJ6M9Wjsn?=
 =?us-ascii?Q?+vaYMNb1gApf0+aQi1admb9WfXu5XmVHAI3CoYmR67/YP3V/x85pWq3zPZd+?=
 =?us-ascii?Q?X1vJHKjphhFsu6NFqv55dLN/jfsNAU3xXqw/RwCaJx3Rc3VfGnrrKPYyTC/h?=
 =?us-ascii?Q?1eEYX9Y7PfKO8yU2NIoyjnQmbyNRIMy++yJmmvbrfPde0htAlf9oSp1WkE+o?=
 =?us-ascii?Q?iuMgfvWNZsA09Yy6dMKbxXFCzf3kJ588OyMKT+NNxvmbAaxRnf9CFU+dp0Bo?=
 =?us-ascii?Q?D/0xiVH/5e1SVFGpEGZaJVff64sK2Kwkn2/xExnblvKSNQ9Aeq75KHtdEwE1?=
 =?us-ascii?Q?7Ysci307aJ+a/N00K0PduNelYbrYL1EFsolHCH2aRK0sPSrDnj03p2+E9cw5?=
 =?us-ascii?Q?ICky2ENIK4/4D4dx66SGP2fDX9dpYikFuw1Arj3nT9dtLE5bG95HVOU0qpEk?=
 =?us-ascii?Q?Kx3j5eJEZw/dkQhJM/aDkJHs/7PlTvfNLsMUJFZ8DRAxUKArO3XCCwO6P+H4?=
 =?us-ascii?Q?WHvfuAzFrpyA//rGIf6aW2+49BooEg6NW4B32AJFC6RZzt1FZlvv9BW2napI?=
 =?us-ascii?Q?/pcY+M90BGhuezFQuZ8ScwYybTV3BTd3vzxp1WP983B0pvhqQTxISoyaSPZL?=
 =?us-ascii?Q?ObfzCaON7W/L7GKdMavuCC8ReYeo8Aljl3poH1wF6AVJeyrK0YqUU3JYZxAu?=
 =?us-ascii?Q?KMt6aCIh+I5WLBEkTLTVhN5U2BriEv1iTQYI6LLRO/eUNaTrQs0DHugGVsfd?=
 =?us-ascii?Q?y35YlswlwA76UYNYVGW8G7buutKAWVqnJpT+id0Cmt/EI9Fked1iuGhhITHr?=
 =?us-ascii?Q?a2SyJYfMJu1AmZEzpG3mUHKcRLJNrTKFy9s8AVbmz1sn9JEYjsVA10O8M5KB?=
 =?us-ascii?Q?4NOxXUq3GQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a882e6-f7f6-4798-7679-08def84699f9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 07:52:05.1145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dV+nvPkyBRJIPK0qz/djdzMu2qGi6tQ6eNvDlQGpCfEGXUnikpWr48CcciiKGwvyZIWkhST/adOEav5Z8dj3Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8113

On Wed, Aug 12, 2026 at 02:09:43PM +0800, Guixin Liu wrote:
> cxl_debugfs_create_dport_dir() publishes a debugfs directory containing an
> "einj_inject" file whose i_private is the 'struct cxl_dport', then discards
> the returned dentry and registers nothing to remove it. The other per-dport
> facility set up next to it in __devm_cxl_add_dport(),
> devm_cxl_dport_ras_setup(), binds its resources to dport_to_host(dport) so
> that they go away with the dport. The debugfs directory has no such owner:
> it lives until cxl_core is unloaded and cxl_core_exit() tears down the
> whole cxl/ tree.
> 
> The dport itself is freed much earlier. free_dport() is registered in the
> dport's devres group, so the dport is freed when the host device is
> unbound, which is an ordinary sysfs operation on the host bridge port or
> the ACPI0017 root, not a module-teardown-only path. After that unbind the
> einj_inject file is still there, and a write to it calls cxl_einj_inject()
> on freed memory, reading dport->rch and dport->dport_dev and passing them
> to the EINJ code.
> 
> Re-binding the topology does not recover either. The stale directory keeps
> the dport device's name, so the second creation finds the name in use,
> debugfs setup fails, and error injection is silently unavailable for that
> dport for the remaining lifetime of the module.
> 
> Keep the dentry and remove the directory from a devm action on the dport's
> host device. The action is registered after free_dport() within the same
> devres group, so release ordering runs it before the dport is freed. Its
> registration failure is deliberately not propagated, following
> devm_cxl_dport_ras_setup(): a missing debugfs directory is not a
> functional failure of the dport, and on that path
> devm_add_action_or_reset() has already removed the directory itself, so
> there is no dangling node left and nothing to gain from failing the dport
> addition.
> 
> Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> This was patch 3/8 of the "cxl: Assorted fixes" series [1]. Per review
> feedback that series is not being reworked as a whole; the fixes are resent
> individually instead. Patches 1, 2 and 7 of the series are dropped, as those
> issues are already fixed in cxl/next.
> 
> v1->v2:
> - do not propagate the devm_add_action_or_reset() failure out of
>   cxl_debugfs_create_dport_dir(); a missing debugfs directory must not fail
>   the dport addition (Li Ming)
> - rebase onto cxl/next
> - rewrite the commit message to describe the behaviour rather than narrate
>   the code change (Alison Schofield)
> 
> [1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/
> 
>  drivers/cxl/core/port.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 625e4aa427db..62a9c2038d1f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -814,6 +814,11 @@ static int cxl_einj_inject(void *data, u64 type)
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject,
>  			 "0x%llx\n");
>  
> +static void remove_debugfs(void *dentry)
> +{
> +	debugfs_remove_recursive(dentry);
> +}
> +
>  static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>  {
>  	struct cxl_port *parent = parent_port_of(dport->port);
> @@ -834,6 +839,8 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>  
>  	debugfs_create_file("einj_inject", 0200, dir, dport,
>  			    &cxl_einj_inject_fops);
> +
> +	devm_add_action_or_reset(dport_to_host(dport), remove_debugfs, dir);
>  }
>  
>  static int cxl_port_add(struct cxl_port *port,
> 
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> -- 
> 2.43.7
> 
>

LGTM.

Reviewed-by: Richard Cheng <icheng@nvidia.com>

Best regards,
Richard Cheng. 
