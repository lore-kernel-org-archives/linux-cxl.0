Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F1F3EA98;
	Fri, 31 Jan 2025 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738338384; cv=fail; b=K0WPkOLbJsekYcfJjyEEr2EfH6jWoJvc6PKL0IPaZxvIENhPwHeexfjAHHjX7CcMWPtzRa7NOMoScUjywh1BPlFQvYkinDq8dK9FQrNaG9/rt7Wogms6Y7CeHGaJP29xMVkBN5Bk+nsVVp+FxVH8BkQxy5KYeBTqIGVNle98D0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738338384; c=relaxed/simple;
	bh=Btrsf431qtd0Z0KzzOgttfKBlAdLYiWXM4C/uBMAyxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iZ8NRwDdBIUTjR+uGrAlYQjSnHNA8KbOyjrsbMn1dcKn/yM7jpqJwSa1p6z9l6sCs7SLAC+4HTbh2dLbr0S4qLSwqIs9o+M0TQkXAeF83mXplvaJoXPm2xZT2ipqCh4Qd50o69Thir+U6nLlrg0XEDP9eya+JjaqnObTvjCPL5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0vX+5j2g; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0vX+5j2g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtrYvuM67o9BtbdaOKtkAd9ZfqhzR8Zgze8ZtJlRCQUu9rU4qYanYj97BQANpuHNamZY5xRTWwF8IBmCMCWsJy6ROhEWErV/ZNcKb0XAfIj+D0clEx61StQ1Xwviltfnxz3oCXFXVgIiLOayGTm9PW+bcZ5i7aEhh5dPfu4V1VZacU1pik3PlvccpX+3ugLknauFQ6a9trW2ydfUOiGjuWD2BKWRLjgzTIye/RtCQYTuE8KNdHuyzGPH1NiFHO86SYm/R8qdQPgzRW+SwJIymeJObHMHJVFpH8PDAjEFCQPg7U44u5uiZex/KeQWU6YK6KBTklo8EkLRMK2a9BdZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=motBO7ClydVopFzrO7jrVMrxlmGDksdWr7WtHdbdqBE=;
 b=Cu6/p474cvfm3gbG5tA1WVSNMAwSHemrsfozfl+guzMIWhdve3kBq3aQji2sSJ6QAved7wzqdaeDwWD6KEYH3WhAOpdC8NlueIEoNkyhfUZSzoC1tWSSHEA6EXdwr3eOKVWLMUfcA7uT/wI/LOSJrkY4zWx1uzPESqnGYYVSSDFFETLgfws+uyFnLxr/rDD8ejthYzF1IcVbWfrhZpENSos6G5Y30AoFqit53cEqwGr9tbBUxpwo9NRIhq6NQ1pp/gBfYh+L2gXS0FbzP5yxZHOpVrV+9le9I2FYX/qW/wLvk+9f/B5M5iFgWnj78cqcsHnxv68Z3xoTejGZlP5x6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=motBO7ClydVopFzrO7jrVMrxlmGDksdWr7WtHdbdqBE=;
 b=0vX+5j2gcbA5IR9/QWPJdqM00n9XCLyxpWOmETDrRiEmLXHKiMJo4usSRb2V9r8s7m5qAUcYLZHIqWFj9Ob9K4Ub2/QkzP6Yd8kY3j5GDTjEYOoBZ32FhHLQ0JrY3iEMOsKRYFUIB4sS2xXV7zwbwraZquVuYTsXF+2jcF0rx3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 15:46:16 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.017; Fri, 31 Jan 2025
 15:46:16 +0000
Date: Fri, 31 Jan 2025 16:46:10 +0100
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 15/29] cxl/region: Use an endpoint's SPA range to find
 a region
Message-ID: <Z5zwQiic51BfULdd@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-16-rrichter@amd.com>
 <20250114105927.00000a96@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114105927.00000a96@huawei.com>
X-ClientProxiedBy: FR3P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::10) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 145f4086-ab07-4914-31a0-08dd420e6615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mT61fv/7i/vwVoaAwtQOEDVNkKwXxjlJ/Uhn6P7/UySE1PVgdCLF2b9+DRRN?=
 =?us-ascii?Q?dwPVBdEy4Gg2khYFt65Qq+AZgRXnFZDwJB6HmYAVpqzCm1YBPjjsq8fGt2wk?=
 =?us-ascii?Q?3CdlG+tbKK1wxPSkfmpB2B7GWEyTtHn5e7rEht99LEhzArXp7KDkDO3Wrn6U?=
 =?us-ascii?Q?7hHYTGIgPFd0K9M95h7exnUwQBYUwkofs9o2phqHsAP6I1V/o4G9p9W0CIYO?=
 =?us-ascii?Q?A4CJ4d/KQZKs2INN1VoYVhqhyeDcp0J9SDGA7iuyeaTmtZKfnR67Q5TLab9u?=
 =?us-ascii?Q?/vBHMccG10q/c+P06NEZdKrPf40q/9KeMoxXPaw4eyX/oOQkYWUkALr8AfoU?=
 =?us-ascii?Q?6BZefqq+sKmVJ3yEScLs5G1jm1IiH8Sm/MvPreOZwV6zKKrMJCwT0y1+zEoP?=
 =?us-ascii?Q?l2U3rl6BXRvrJafEFn3RZxXv0wgQ1JGl1FhNAIFXk/mLm3JOcpOwxluQqdXg?=
 =?us-ascii?Q?rzjPM2cWj4zmp6vNitX6b63O6zQ2TU/b9VcwDFc6b17d0UJFkA4+XPP8qL/i?=
 =?us-ascii?Q?T/I/yWdoVG0MJNjS0TWri+utJnjC+o2ly59JWbvaxFvA5ae+FVrs2dey+smD?=
 =?us-ascii?Q?HlXMYlgdEdTZCkJUXii8/IK7J5iFar7wfj558WKAQ5xVDJdUJF0yzmgLIWEs?=
 =?us-ascii?Q?hnwGN/3EMZ+B4/RM/YuzZLCD2lq9B1w2Tmv6PBHm6e6f1b8eTKxyYAh/soPV?=
 =?us-ascii?Q?+EB7U0ppmv6g/IfOAvoZHIjI/sYJhOA5vT5FOLklIvAL2do39pxJYjVbZvNS?=
 =?us-ascii?Q?ridMG9/Uzc1e69Q5zNQTZCp7YhVPLif/7TjslhuUyn/o/AWHEEE+kIrs7Xni?=
 =?us-ascii?Q?7R95IX3E+HyO467IliEw2Ma37kXpmvNPIT/4ITNgxPbV778iPdbG6663wX6R?=
 =?us-ascii?Q?m8dBFBSsh+OCLNkk1P9mXD55LRBo8ek75ipoPLxb+lAVqHzD2R35lW3jWsut?=
 =?us-ascii?Q?Q7pcbn0ZxJplnjryaHfNrI2nNYzn8NVqMXzvvZqmQgX1sfg+GgdY62jA61MR?=
 =?us-ascii?Q?/PA7wUycRf1luE8UctuG1z0W+c9asTYbqjIiBw34SNWW2o7GwAEgKZkJjE+Z?=
 =?us-ascii?Q?Xi8+wmVXmvUVeqhP6NIsMBs1xxw9kYECMoLBI11ndLaq/MnASG4VeRSce94x?=
 =?us-ascii?Q?4OjeO9ciCUcA9QpydHv7Pcs0TrYFyXHqnr/F64J3XorYv+3zo3sVimNZTYi0?=
 =?us-ascii?Q?sCtfpN7yHhX4VwYEMLHtCWGYrIP/dJJ7N4cO3E6pK2GwM0HyvzVhxhRq1kkX?=
 =?us-ascii?Q?l9ZbHm1CgWB5IPXc4BRJKTKZCp7/P2GAK8l4dpOas2VfxVyesb505Ek/htxB?=
 =?us-ascii?Q?aPXLVxAqldt1n9onZRLP8k4Oac9q9kgl3v5eN/NyWFDh/idhmYnWm0voOCJN?=
 =?us-ascii?Q?ZYI9DZThriIEBk8LFjV2joCW45jc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l1dEOfSi3a++1UoGfv0OSuJN3mSQKurBGQjQtvdGY3bNjympzYHQLQUcL3fd?=
 =?us-ascii?Q?kTNT8UA7UNoCympormdv//++Wl+3+w6h2gQaU/1expWVpD9GQ09Ml8tXyaE0?=
 =?us-ascii?Q?XXsqggXVkIDy6uzY5BoElDL/kISI1UBadXnLFPWIcUvwcw7Hmy/UHpvAw35h?=
 =?us-ascii?Q?ViEvKdydw1unCQBucbUGPNMLBH7b+C/Fbe+5sOQrEQ3Jhy9Z0IAkp2Yd1/j3?=
 =?us-ascii?Q?kkRqky4uLsHzjRxEJrQ80YK45IjD8mT2J1V5nFxYaHLnKS39LZFUsYUwjTxc?=
 =?us-ascii?Q?jvdxq6UwnIbGE+ZIW0QgzE/Z/tRhvoe0XFOaLLOGqURgoRTPzu7ewaD1O95K?=
 =?us-ascii?Q?NKUu40//lkdzSDmCfDlFS7EQOAPwnlfIPbXRHl5JHroIDcK7O72y34ncwwyH?=
 =?us-ascii?Q?fccuEl8J9C3Fn6LcT2klYjKCLQCowU/d66wM7LXX+o1Z46bt/Qwz76M1dlCP?=
 =?us-ascii?Q?9UG7/mKPy0xZfuQXh9vPpWllmKyiCuxmXoyncnIa4kidmjNZRnLPWihD4PsM?=
 =?us-ascii?Q?/+WOXiX0xF03GTth15bYCUchtWA2kQVyOEisROy1jJVpwDGTmKwzf6Qb84QH?=
 =?us-ascii?Q?0OlanFXAJ3NQ1+LAMcx5/j4fSRLdaC2/H+WFgh+Qm1qM6dY0lIQ67EV4EEmq?=
 =?us-ascii?Q?QMp+QAFJdv5xlNhjobmCgkQrorUiKsm+FKPGs6pcfCt0G5devGp6mZBYRelG?=
 =?us-ascii?Q?Q2B8JVWmgKi0Dj1e7L4Nk1Lfky6QeASkhPxz/oDSbaEUaC5zeIVExkETH9Kq?=
 =?us-ascii?Q?e3zkEvUf4OrGb4tBNW87jywwKZYR7ClEmjWvmq82SnH+rNMTi9Twd5C7U+t8?=
 =?us-ascii?Q?N7sgXz8zlbO31wCPYrmOf2rv8T+bmbDq+pjc1JVztFDVFVwmmBPM4cHu+Osu?=
 =?us-ascii?Q?ucqGbK7Oc5ZlI1KpdXI+Yt4UzySKlv6MBnsr9s6ECEpTVwTfhuWKldUgMcu4?=
 =?us-ascii?Q?1gPMjdxlAI/MdKbCh0trceEPEmKbhjLP+BSm5+ZSRf7m+T9U2Oo1KYqiqY+6?=
 =?us-ascii?Q?9/Y6rmKLM2hNM9JhKiYFbEf4ye/g0Ia/M+UwKEvwCDnb4Ip6sfA4vmVVz2wM?=
 =?us-ascii?Q?06Z1+pDTACJhLy7LOBYGMfnsuqCSmER4MwKme6ej8kmOx6XQlUTKeuAWeFZm?=
 =?us-ascii?Q?NLenkhwMYbDZRXCuhLypaS4yTv3fpDfrKidFhw/rZCGyUazDCu2HSNLayvwW?=
 =?us-ascii?Q?lbO9xlhqQsRSjxx6OA6VS1xrMPS7BvZ6+X3o5Tdu6CmGrbF2NSvdjbAYu8x+?=
 =?us-ascii?Q?eB3Eo5L2iCrqZ3bbo5sSNfzisIFyZ0FUtAzUCh6hKOVi8hFb3oN+l9EtRZp9?=
 =?us-ascii?Q?vByUuX857FEwrNyx6t7FneSBYGBZxZlZnTu1QSiih78l56JAXnX9WFIm++4/?=
 =?us-ascii?Q?Dl1bzeAM/anbzPp3OWoow8+UOQuPDOWysULRbNK/c5xzK9wl6KQP7+eXSi7L?=
 =?us-ascii?Q?FvhDRpoxRiSOm5P7PCDfYRptggngJrCJOgoRIN24YxfFPJHYesxaiFygZ8bP?=
 =?us-ascii?Q?Hwf1AFIuZ4SvYvDvBrUlqYrBbi4tMM4G2n6yrt4t81sp+X5tAg+V93ob+SM9?=
 =?us-ascii?Q?91Sfn3SylZVWMU2cndASBYXJYWh7CV0k/+Q81t4B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145f4086-ab07-4914-31a0-08dd420e6615
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 15:46:16.7922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTr4gAPDJkh0l5EsjfdeiZBxwJ/DRcpTbIaZc9alcHUclLj+KmdqAyioTKtXRFOmOyOMMeMC18ZbDU1ksFdMRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724

On 14.01.25 10:59:27, Jonathan Cameron wrote:
> On Tue, 7 Jan 2025 15:10:01 +0100
> Robert Richter <rrichter@amd.com> wrote:

> > +static int cxl_port_calc_hpa(struct cxl_port *port, struct cxl_decoder *cxld,
> > +			     struct range *hpa_range)
> > +{
> > +	struct range hpa = *hpa_range;
> > +	u64 len = range_len(&hpa);
> > +
> > +	if (!port->to_hpa)
> > +		return 0;
> > +
> > +	/* Translate HPA to the next upper domain. */
> > +	hpa.start = port->to_hpa(cxld, hpa.start);
> > +	hpa.end = port->to_hpa(cxld, hpa.end);
> > +
> > +	if (!hpa.start || !hpa.end ||
> 
> On general basis, why can't hpa.start be 0?
> It is an unusual physical memory map, but technically possible on some
> architectures.
> 
> > +	    hpa.start == ULLONG_MAX || hpa.end == ULLONG_MAX) {
> > +		dev_warn(&port->dev,
> > +			"CXL address translation: HPA range invalid: %#llx-%#llx:%#llx-%#llx(%s)\n",
> > +			hpa.start, hpa.end, hpa_range->start,
> > +			hpa_range->end, dev_name(&cxld->dev));
> > +		return -ENXIO;
> > +	}

> > @@ -3214,26 +3249,47 @@ cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
> >  static int cxl_endpoint_initialize(struct cxl_endpoint_decoder *cxled)
> >  {
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > -	struct cxl_port *iter = cxled_to_port(cxled);
> > -	struct range *hpa = &cxled->cxld.hpa_range;
> > +	struct cxl_port *parent, *iter = cxled_to_port(cxled);
> 
> I'd prefer that spit into two lines. Mixing cases that allocate and ones
> that don't isn't great for readability.  Would also reduce the diff a little
> which is always nice!
> 
> > +	struct range hpa = cxled->cxld.hpa_range;
> >  	struct cxl_decoder *cxld = &cxled->cxld;
> >  

Changed both, thanks.

-Robert
