Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8421F136648
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707165527; cv=fail; b=L6zFXU79chNEhRwSgktlPwPYmXyEz/fa6gyjAsX5R5KZS+y/x188WBno2sWml/DUBANnhdy/LmPDDQhAIZk3z9Mi9jUzgvyI7JwqrCKk2rr5vwMFX/LN4BkRqw/lPav8xM0uV3C0uRi83luwCXdsBSIwKaDFgutVbLmaBUL/4O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707165527; c=relaxed/simple;
	bh=rnFi2YuJi3yt/P5BluAABog2pZkc7A3A0kT+r1IqRqw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C3B/T7q5RHDtYX33DpAtZbOdTnyAS+VG89r91GhNvFR6/SJeVwgajhHTopgLpk/hhqj86Duv29zVeN4/ZuIwv6vSGVCWrrFP9+WgxcMOLSc6MrJF77S9Zr883P81S5l00Yt/+EeqEw19W7D/2JHvVVo1hfwcTyxcLACH1b0hPu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Whl1ZdAO; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Whl1ZdAO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707165526; x=1738701526;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rnFi2YuJi3yt/P5BluAABog2pZkc7A3A0kT+r1IqRqw=;
  b=Whl1ZdAOGB71gosC0lK56IPs9BKEOS/H9dgebGN6F7yP2Sl6Yf9fWrGH
   ANybBFV99W7DAIpndCssv6mt5ZYf0pAxP/YQomxb/O5ErVn+Z6x25L8dc
   GfB2fTDzAtLoFQ2YWpyZDWCsnh9st5JlBcay44mPOS+Qhysxnx/YSvpTU
   IL9JpILaSzVFtkl+u8zH4phtXFd9409hGAnqKsbmk+6cNxhzt79LgnS8m
   O4oMHCz6NvdOlU8FX+1QBlrw0rzSTMMazOKG2JNCwD+RzcDiWDLzgyyVo
   F1xaGSQkJK6el3oFFkqHf/cGNzmLdHObgjf9Qs+bQhHOW3VERndm9fKLV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4396094"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4396094"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:38:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="909398030"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909398030"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 12:38:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 12:38:43 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 12:38:43 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 12:38:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luh2860mwkcHE73Qln9288rmDOuBRtyF5DWDGgUbvbNTSD6OPfvtQNQpQRyzPZ8c1INwsUIyzmiUVQGX4MhdWYMOk5RniYmSDMbZ4nb1vtsOXr7DmhXHmzSUAzFWl2sw7rrYPzDUADBrrsbV3lulJ96FizkAaw8KDbjQY5pRzvNKZgHbSs6239TztSPH/9Q0Kzr02QKdfvXGaxy/UNKjZ0dfA+n0HAVeSxRNhaFM8OtL3unAJX0yunkDc6nFDoveMKCn8G/HDITzORVxFHjY7vwmv2UNGh8IGMJbfXr+8xDRX21Ni00EFIlw7prOPBeL8lBNrMnbcbD4KfvuBoezMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pBafq1B6UaSh2e93B4aBSRR30XHq3Uvge1Uk4lWW7s=;
 b=d4yW6PqwjZb8i/e6h4haxrhuLdiqG5RdpyuL2sX2byp5oKeedweSerVtLaBpjBD0Ko3t+oEYRnppPjD3JiI/Fdj6X4g3k2RonMR+DVRTG9wH5GBsqORqhxk9husuneG3Yjy/6GNpQ9yjMrdG55NKRB7bunbwWxVabzhRAnXOIozF7buhEnyFyDa+pBFQhc9xsZyRidWkQxgq8P2pMUrtZ1U1K5b+NnhE5uIinYPWsCG+w3Jlcc2jIrflUil51UZ4/0P0rCDuJalrH7RVhpNeNIBsL45ZZ/EidBJJ6ybzTczJ5qrWTg9eNWLou1z9SOmKiuELRIM2f4FjfrkTh+njgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8761.namprd11.prod.outlook.com (2603:10b6:8:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 20:38:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 20:38:40 +0000
Date: Mon, 5 Feb 2024 12:38:37 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: RE: [PATCH v4 3/4] cxl: Fix sysfs export of qos_class for memdev
Message-ID: <65c1474dc8ce7_4e7f52946@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240205193218.1657243-1-dave.jiang@intel.com>
 <20240205193218.1657243-4-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240205193218.1657243-4-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0336.namprd04.prod.outlook.com
 (2603:10b6:303:8a::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0dbdd1-55ee-4518-d3be-08dc268a6fa0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bzf/IvHnVMfCj2CIvOjsMTddW7FtQ8BGSNOlmlTx5RY3hxax/C/JHwa2UlBoTjiYhuQUHtNlJ+mayREkla5RIEQgVBQ0zHBIkuqwiu6qudaqo2hRZzmQNHxuFGm1Sz3qAigd1XLNeAydChBJ9g4Oyxe5XyAB21rudzlOTSCT2pcD7RQnqE8Uv98Lxs1vaDu7ixjpoJHXZXU01hpANX/xE9vMX2NYGJJIWwd2z0heudRcvmAFhVtpt3vHr1V75M8Q1TyKJTX6iSMSlAqxmTQX/rMdvcpZEp2XNNZuXjHL7M0RpR5HxQzuJm1L2oiyWBhqVNQUN0avEf1HKH2lq2+sTXE4Cxktiuwa2ylSmRgFQuxAp3fQ/+vF6BNy03cT5s1yFfZbl96WOps2+OHoBV1LW7yPcE8BCbm+DOYKlPXIYNUPFQ5eCFw6ju8iZarUDZTFxqisF29RToeUsvXVkWdF7N/Gl4+61YtBOMuyAeGbT537bDfg3KnsixWe6hEmKC5KBcbHFtBmc2uSxuFaxkwMDlbTYP+JCQkOri5FKHolYXdDDCCy4CLq4a/c5F8jBZDM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(38100700002)(82960400001)(6506007)(6666004)(83380400001)(26005)(41300700001)(86362001)(4326008)(8676002)(8936002)(6512007)(9686003)(2906002)(6486002)(5660300002)(66946007)(66556008)(316002)(66476007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8dm7fnB5rkWcwSrKQ4EbLlfxcGDFLHXi6+xtEFDDo7QFV5DgexvJOJrRQeW1?=
 =?us-ascii?Q?HxJ/i+bfR711ycAjHdAIfmQYQAAWIH7/yFwf/D8w133bruqCVeQL5DtVPlPb?=
 =?us-ascii?Q?sjPmSKopdCyDJI8mhP1RhB6et56vPk3jLlY+eDVIOgJnzhY9ikrfQLgjBJcC?=
 =?us-ascii?Q?nxE9ztpSKcUHvXFlKM5OQ2FXpgfxQAuJmyHoSmnTT+Q85DVD04WgcUsoFFjN?=
 =?us-ascii?Q?fH7eYHLbbzhQIpenIAE00g5imeGwjtvPff6JRPAd8WwLxTUaO4EYQIRQeOkW?=
 =?us-ascii?Q?yg8k0Y31wAXrofHY5bA9c/jBtMyELS+UI45sQt5kQjAywXpcOYAcq5zmV7lg?=
 =?us-ascii?Q?7IG+0O4ABaMQfwvkWytLo1Vv56xsiykNIaOof49F7y/LEmgVwFTQ0HtjFca/?=
 =?us-ascii?Q?GNlo8d8fa9fURpJmCQ5uJLQCrGe4GAx8zk2/xBydLXSWb3Ht/0EEqKrEVmkt?=
 =?us-ascii?Q?DjIgxVoc6g9ReypHQnmXZTY08TrYU/AwrJHfEFHBedckJXA7KRCbVYi0z1Wh?=
 =?us-ascii?Q?T+p9kVoLNJFkZVWQtTItWRtrYxgy/ZrLM6sU8kIu59+hxL+mInhm41G82oIh?=
 =?us-ascii?Q?VAX+KoaqHwT9trvdeUYCYTOj8PhM3sy7FipiyQWYjmj/OX3zVR1PJJOeMVVk?=
 =?us-ascii?Q?jDi07hh8XHSof6osd+7cIEsSv67pBtOMwAANuWP+M3vHovCYVqjUrsgfU1pe?=
 =?us-ascii?Q?zK4SNT1uFrXNO3ZH59XWgtTMV5YyAn9sC2QgwpOwrx67eHa8FCTfw45z0BTN?=
 =?us-ascii?Q?alVCXnSgIVluBL5GfaxKl3lMup4DptI1wvgvuWfvMRtSRkRW4jisVTqXzUub?=
 =?us-ascii?Q?RrFYNOfoewAzgb1KdcUHomnNXEqrJryxXlNjx8STOggc81bKp1OJ9JIdO9AG?=
 =?us-ascii?Q?0sFNLq0tn/K4fJkkUimMy1J9DMOajFhKyKN6ukRQ1PE2AlN3Bibmrq3KcPUq?=
 =?us-ascii?Q?53iII0lsPMHexeU/eAUUyfRdnarRxooMa4PgOwsiJFvXj1DqtALuxHHhHWpZ?=
 =?us-ascii?Q?dkfG2ulkCAnQplX1orTMr7sojb2l/ql1NKwP6csTgUfaViF4BHLwRNQpVr4U?=
 =?us-ascii?Q?bHWqMypLeo8RkmwBzIq+/67XJ0F1/q2oyV6DLwl1Xu0UxcnWmxLg61hj6tS2?=
 =?us-ascii?Q?GdOaaqAu9YbkaEcA5wXRKcnTYdtqIuth9MB9J/COvr9fKxdeWrXJrM8wY2RR?=
 =?us-ascii?Q?UwNQFT8HbkqzRUQkAE+YdGyKAiuGnmuUOq/KsCBNi3wyytA50Zec8ZAnzTVJ?=
 =?us-ascii?Q?T47eetzU6RK67A5yWKgd9T3qd3aqzFXFKK+hY5A0zjamwYK/2q0bmGNHNAGX?=
 =?us-ascii?Q?O4EwLt/XTLsuvaptjDuYytHUvIPMAoDcHbgD/VRa5YDAX+Pvpp3noytrQxY+?=
 =?us-ascii?Q?Al48iXTPy+XeMgVHdYFCVyne8+XrcP07vfvrCKlMi+pimUO2a1K1I4IBYZQ1?=
 =?us-ascii?Q?9vMtBCvqlBbojvhMWRF/G7KXBNzW4x1GEi1IFO6i/ZcxzvaUuBRiorFAD2Lt?=
 =?us-ascii?Q?An3AinSZ4H/phS7MDgeqxZkG07NG6LD4/K/BDD6kfT10hEdkCOG6c1eDy9Am?=
 =?us-ascii?Q?yvCe5kpS/tWET9fW8Slde7fhAbFn1kbmThuG9W1++1RWD8uhSrjXe/soLJwz?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0dbdd1-55ee-4518-d3be-08dc268a6fa0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 20:38:40.1445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KEfWQOt6AQSXSOm/3VCaFeZulUlkKru+gBSZTILrmkMVskLC8pwPPObF1w2kCoRMAApacLHzjxD0b3QFi17c8EFllW0Fec4/Ddj7cKm+JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8761
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Current implementation exports only to
> /sys/bus/cxl/devices/.../memN/qos_class. With both ram and pmem exposed,
> the second registered sysfs attribute is rejected as duplicate. It's not
> possible to create qos_class under the dev_groups via the driver due to
> the ram and pmem sysfs sub-directories already created by the device sysfs
> groups. Move the ram and pmem qos_class to the device sysfs groups and add
> a call to sysfs_update() after the perf data are validated so the
> qos_class can be visible. The end results should be
> /sys/bus/cxl/devices/.../memN/ram/qos_class and
> /sys/bus/cxl/devices/.../memN/pmem/qos_class.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v4:
> - Replace open code with sysfs_update_groups() helper. (Jonathan)
> ---
>  drivers/cxl/core/cdat.c   |  1 +
>  drivers/cxl/core/memdev.c | 66 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |  2 ++
>  drivers/cxl/mem.c         | 36 ---------------------
>  4 files changed, 69 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index ecbd209ca70a..f5bebc7e7ccf 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -382,6 +382,7 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
>  
>  	cxl_memdev_set_qos_class(cxlds, dsmas_xa);
>  	cxl_qos_class_verify(cxlmd);
> +	cxl_memdev_update_attribute_groups(cxlmd);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_parse_cdat, CXL);
>  
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index dae8802ecdb0..c81f2cd4bcc6 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -447,13 +447,41 @@ static struct attribute *cxl_memdev_attributes[] = {
>  	NULL,
>  };
>  
> +static ssize_t pmem_qos_class_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +
> +	return sysfs_emit(buf, "%d\n", mds->pmem_perf.qos_class);
> +}
> +
> +static struct device_attribute dev_attr_pmem_qos_class =
> +	__ATTR(qos_class, 0444, pmem_qos_class_show, NULL);
> +
>  static struct attribute *cxl_memdev_pmem_attributes[] = {
>  	&dev_attr_pmem_size.attr,
> +	&dev_attr_pmem_qos_class.attr,
>  	NULL,
>  };
>  
> +static ssize_t ram_qos_class_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +
> +	return sysfs_emit(buf, "%d\n", mds->ram_perf.qos_class);
> +}
> +
> +static struct device_attribute dev_attr_ram_qos_class =
> +	__ATTR(qos_class, 0444, ram_qos_class_show, NULL);
> +
>  static struct attribute *cxl_memdev_ram_attributes[] = {
>  	&dev_attr_ram_size.attr,
> +	&dev_attr_ram_qos_class.attr,
>  	NULL,
>  };
>  
> @@ -477,14 +505,42 @@ static struct attribute_group cxl_memdev_attribute_group = {
>  	.is_visible = cxl_memdev_visible,
>  };
>  
> +static umode_t cxl_ram_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	if (a == &dev_attr_ram_qos_class.attr)
> +		if (mds->ram_perf.qos_class == CXL_QOS_CLASS_INVALID)
> +			return 0;
> +
> +	return a->mode;
> +}
> +
>  static struct attribute_group cxl_memdev_ram_attribute_group = {
>  	.name = "ram",
>  	.attrs = cxl_memdev_ram_attributes,
> +	.is_visible = cxl_ram_visible,
>  };
>  
> +static umode_t cxl_pmem_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	if (a == &dev_attr_pmem_qos_class.attr)
> +		if (mds->pmem_perf.qos_class == CXL_QOS_CLASS_INVALID)
> +			return 0;
> +
> +	return a->mode;
> +}
> +
>  static struct attribute_group cxl_memdev_pmem_attribute_group = {
>  	.name = "pmem",
>  	.attrs = cxl_memdev_pmem_attributes,
> +	.is_visible = cxl_pmem_visible,
>  };
>  
>  static umode_t cxl_memdev_security_visible(struct kobject *kobj,
> @@ -519,6 +575,16 @@ static const struct attribute_group *cxl_memdev_attribute_groups[] = {
>  	NULL,
>  };
>  
> +void cxl_memdev_update_attribute_groups(struct cxl_memdev *cxlmd)
> +{
> +	int rc;
> +
> +	rc = sysfs_update_groups(&cxlmd->dev.kobj, cxl_memdev_attribute_groups);
> +	if (rc)
> +		dev_dbg(&cxlmd->dev, "Unable to update memdev attribute group.\n");
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_update_attribute_groups, CXL);

So I appreciate that Jonathan pointed out this helper as a replacement
for the hand coded loop over all the attribute groups, but I don't
understand why all the groups need to be revisited when the groups to
update are known? It is also a red-flag to handle the result of a
__must_check helper with a silent dev_dbg() statement.

Given this qos-class support is optional, sysfs_update_groups(), with
its violent "tear it all down on failure" semantic, is too heavyweight.
The failure can not really be handled from the endpoint port code
because the side-effect tears down all groups even the ones registered
before the endpoint port driver loads.

Instead, just do something like this:

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index c81f2cd4bcc6..d4e259f3a7e9 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -575,15 +575,12 @@ static const struct attribute_group *cxl_memdev_attribute_groups[] = {
        NULL,
 };
 
-void cxl_memdev_update_attribute_groups(struct cxl_memdev *cxlmd)
+void cxl_memdev_update_perf(struct cxl_memdev *cxlmd)
 {
-       int rc;
-
-       rc = sysfs_update_groups(&cxlmd->dev.kobj, cxl_memdev_attribute_groups);
-       if (rc)
-               dev_dbg(&cxlmd->dev, "Unable to update memdev attribute group.\n");
+       sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_ram_attribute_group);
+       sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_pmem_attribute_group);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_memdev_update_attribute_groups, CXL);
+EXPORT_SYMBOL_NS_GPL(cxl_memdev_update_perf, CXL);
 
 static const struct device_type cxl_memdev_type = {
        .name = "cxl_memdev",

...where failures are truly ignored.
