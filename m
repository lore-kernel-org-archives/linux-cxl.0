Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755CB1C01
	for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 01:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719452760; cv=fail; b=VZh3u7j0iMXjXNfKVQxjFXgTN7ZdKr+QT1i0ROiJGA9PWXsMOLmUn8U43YK0WvQAE8RdHqAkiSc4/WPomSUpXcG6Ot937SRiIJVpt7HWqmW+u4C4dV+vM8vr0ShKO/zrGq3gsYBT8OxPSD2j0lLfL7L97XzqDSPzyf2ZNgM2ZlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719452760; c=relaxed/simple;
	bh=QEmSXpBhrMPiF+W1f+WFJ6zL78wxKYlqKPhttY+pPm8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j0cBtpN0fbxF2wBNoM7/ZPdWVEAEvwF/XLLgpwlOptomwaCO3xuZFQZ1JX15YCUm4ipk4r+N1xdBneMK0aktwr243qYYPHTN4kfFyQxmFMWrJGnxPPlaR0IiKfzsLemLvprQDCIBnqSZ8zh+p0ocjmGBwdwcCKbD+T1G3w2HfQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VhbNhKs6; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VhbNhKs6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719452758; x=1750988758;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QEmSXpBhrMPiF+W1f+WFJ6zL78wxKYlqKPhttY+pPm8=;
  b=VhbNhKs6w+JICUMq+l7Ro+V+UEIChpviphKk5MRSChviJBFlEcstrI/3
   7iumqW6WA6yI/iTaphv4T0PWJj0uU9wf0WUA/Ty2UzwvGWYypdGzdxeR4
   HIRajyPUh8fP+MNCGHgIykkVGU+D5FWVv2ocCFrNfPntzFoukl0OuBfim
   tgtnB3f8BcEIJ9W/Jw++6HzUSqUInxZT6kbr8FSi60yepKOoylQ21ID3C
   aUuKb5402oaIw79iNNk4K0ntf3NGrBxv5OHET0IjIqaTPptyPwGF1jeh4
   TCu0wOzWWtWDUAV+yoL+0KLwJl8LhEGgfr1+8chdeNAp2pltv3trv0Goh
   g==;
X-CSE-ConnectionGUID: d8A5PoQ5Sq2E7wqZYtfrig==
X-CSE-MsgGUID: GOEvDLMRROSeAi+nyzreUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27693401"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="27693401"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 18:45:58 -0700
X-CSE-ConnectionGUID: LvUSfJvnQqyITK34FUZ61Q==
X-CSE-MsgGUID: +LkUKDzwSqCOf7DBNGdIrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="44319146"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 18:45:58 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 18:45:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 18:45:57 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 18:45:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuoCbMhPS+trogTiok2tuSH3bb0D/glAbdr63vFZClDxdp4TQ3SRXU1afxo7qI1k+PA3Ow3rpiWu828XUauzo6dQ0JebRmorfvRLM4944G4dHw6LwgTwQhSpoRolrzuVAvLWBVjABEJ4bH6ZYrqFuaJKfIrIjjUEZz4fe4jxnnsJUEGGaudc1KP1FQ9f/e13Mb/vtdWiwry0e4O0m/mKbLSWeKVCMLyiwrZ/kveflYolTKsRn0SmQia2IdNI08zWyaoVVrg4DaBAtRw2CeIh5sZ8aMGnz3cKNFzZGekfBoynMgrLE5gasZaP5BmIkx5VBRl87PeOmH7uj7BGqhPayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFGpaiphthVAIcJp5qbltCZBrbHaAupoQaqDlqAo5/U=;
 b=BBhSe93E84BU2V/XDr9oQGUIGWxuTN5q3/CMLknkWIPDv2PW8MGtyj8h9K1SmnQb6v6qKvGeY3kvPOnZFe7ZB5aQBGresL5AKku9CPHNg7+rkCAJOshxtmTRHSIZKmG9IfBpb+5/A+fdYrywxeruH5TWCCAR1KkfWEHcc6zAqfMAs0zFfpl11fg6OewGY5pVK9zZjeJxNaimqkHWED+6pRUJVGA6JSPf1z9LhQu9xjPLg3U/xjJCc0O8Jd6W5pZPtqZXdD3Fi6SsoqWLBegzzCdsRUW91MyIOTIOhKYsdln22cE14U5QR3pwWaorFTyDEbuHOVk4H56u7bIocyYP9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7658.namprd11.prod.outlook.com (2603:10b6:510:28d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 01:45:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 01:45:54 +0000
Date: Wed, 26 Jun 2024 18:45:49 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] cxl/core: Rename cxl_trace_hpa() to
 cxl_dpa_to_hpa()
Message-ID: <667cc44da5af8_563929489@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1719275633.git.alison.schofield@intel.com>
 <3ed59646c9f1400432520845e482fb0341af4d56.1719275633.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3ed59646c9f1400432520845e482fb0341af4d56.1719275633.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0130.namprd04.prod.outlook.com
 (2603:10b6:303:84::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 6870b68b-56bf-43b9-6216-08dc964ae1f0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LN/1h9fjldcU/piEzjp1dQ5X75ofZUuInxn1Iq0qRYk36J8b5hDsbnyRxbKe?=
 =?us-ascii?Q?1RL9MxBmZx/mmYuCkiJV5fCNsSip7RImtspC/0Kb0FLSufAYYx5UKOlpzRYv?=
 =?us-ascii?Q?VI4ZsgYd3RsLyMHQtA1nLDe3WYFZQ0swlDgLpjF86OCBjdowWrg1NZ21s7Vb?=
 =?us-ascii?Q?7rlLPNM+bYwAO0RkxEosRxTjv1w4bu7CK2+9gzei7RVvdt8nVSKD5v3XqT4H?=
 =?us-ascii?Q?7DdFDfjj27S8RQIOu3gVTzksUeodGAb/icFWMc01cYEQddFo4p+/e68rXfq7?=
 =?us-ascii?Q?kEJOpeNowe+xbuG/tzJzvCmfUKTKmp7Soi7mAkPqF6He/hxNhe+qf3p6OtG0?=
 =?us-ascii?Q?mmvV10cvV15whUDz47W7X2Atkt24PyAydtGpHEb9ZJQj+U1lHa/BEsji17WQ?=
 =?us-ascii?Q?rRy4MjccqN/E+YvMMWfAlAQK9p7DdSFtDAPHlaGz19KQ9o9jqMYSriZahxuV?=
 =?us-ascii?Q?X3IjOGaH5uJn+eBX5WgYrTssVrHv8yfqAsIh2wOI5qFwJ9MJDNAHDjXowmCh?=
 =?us-ascii?Q?wpHQdzY1J5Ail+92+T1/nNP4du0OdoOthrXx/A6jlvxzUjVRoCZ8kQPq8g6n?=
 =?us-ascii?Q?0wGL+9WOt0A9YpanxpJLtVt3T76i7j33aE5YhYleuyaj81FwNgFpr5dw49n4?=
 =?us-ascii?Q?HFdSxqdI9eTIUaIOXqJ+BGLIy2wOKsjsV6exVpFAg+T6fK3VNLhRpNme0GcJ?=
 =?us-ascii?Q?/qx02i0ioa4dAEAMoUlLd2enK4NrbBDhlfCN6ZqPIO2xpNAOu6+nyD3ip+Ye?=
 =?us-ascii?Q?tYWZxVSRt2a/JyHTvO4AF0Kpdd+lfwX387tWk5ozw8PP1uxihRAAo0djapzX?=
 =?us-ascii?Q?TowZi8SGucUUkVL9ZcKLk6RtCkdyY7mrjgJ8/7BDAnDZawSoUfVZDXSlbBSX?=
 =?us-ascii?Q?w3wRs8/uF+YNfjryBJK+N4obhuzHWMmqglmKtJoRUn8oDGQx9wD3W13cJrgz?=
 =?us-ascii?Q?9ru3lcOyBhQhayiyEmn6tvBm2LDtk2PO4XfctLmAx3oOIEYSaaJns2pq8WmP?=
 =?us-ascii?Q?F2P5xYJm+JKJ+LWLArnPv1TisChRLpyMjTW5IX293yo0tJbUlekrtyM2vQry?=
 =?us-ascii?Q?g2qTzsmrg+seE+nQoT8W7rR3lcDNBciXudGT968+/RqwwQaIVjP8znAeojsT?=
 =?us-ascii?Q?3wz2jVnbgS7AtCbkNM1NGJ2zbwe/Kqpo5TNj/+kPioNliTABY76j02HhtBBF?=
 =?us-ascii?Q?Iz9XiaUIpYYom/IGvEUuVq0d4mVJpmx+dpeNGWRp9YMurGdAe0X9+vE+B+r2?=
 =?us-ascii?Q?4OR4KN5pbaMeblcVFrZGtrMpEdPApASJoPHNmvijcZOFZPN0Ct7K4v16to2s?=
 =?us-ascii?Q?MCpVH9DQXalxm+JMYb3igpgmgpvw8zqPRm4AgVWp/UIvpg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YE7A+bDFfTRcwB8lmNH+2EAXYfjqa5ayLGi2K6/6aurf3NpdtnGE4bHQegqC?=
 =?us-ascii?Q?ewCiXG8DuZGYU+XJqThB/xZWx+Z0Rk42ZaSQ6qrsoBiGVJF8GKeEzbzU5Lgi?=
 =?us-ascii?Q?WNfHBLWktf/s/Cnk44qj1BOMvLGWHQZwZhnNeGOy3tW6SqJ8sdKBSRHGk2aX?=
 =?us-ascii?Q?mpWYAh6sox7vvHl0DCSWOy5gEVn2eyq3B6J1B18Fs2jE8b6qcafpMrKGmQZh?=
 =?us-ascii?Q?RArrT7GtpzybcOeTrhukEXSAqFH8ii+OQgXZYpqok0DDM+orikqSDD/2/wxr?=
 =?us-ascii?Q?j+dMmvq266sAsbJbA0GnaI0ds6ws/5N468Y5UuTMQUZbnK9od47Qm7N7GnFx?=
 =?us-ascii?Q?bMW/EtmJFqwqkq6BIx6jmRpJgLEMfmUjHmmE/77aMALE9aD85OY8xbqtbTGZ?=
 =?us-ascii?Q?oSCEQyGDnfNxLqJPkmNq/8rNVZ3oOkRxTnNxoNHRL9kTYCfVGShts+MpMw4/?=
 =?us-ascii?Q?GaIIWx5uFVN+7CufJHty2DXQ/CYYKivFCnTYrOnGG9XfqPqDpu7SpJ5egfvQ?=
 =?us-ascii?Q?q8RBaUdafI+be+gGm5CwdEjKNdIVffApsm1DF3IWTKsGs4sZejcgNFNxTyZE?=
 =?us-ascii?Q?R4vDYW9i2ZqDO2ef1iadNu3KTmks357/qx8S4+hvJsea5Hay0iFEhirzn/6q?=
 =?us-ascii?Q?eTCb2sRQCwIaQolpVqClJmlZPYe7NppYKD0owS7qGhdEgBAsUgFwefyZiomu?=
 =?us-ascii?Q?WLHnGeKYKG10ggHCG3NUW9O9lIdvqqz9PWgCa9MuLlvkxuDpowd0+SoIq6vh?=
 =?us-ascii?Q?5EjFa7I3E6N2yWte/ScQpkHdjzMd0ywlS+0FFD15GOaRtNfTpFJiThc+HiLh?=
 =?us-ascii?Q?BawuviA5zNvHXMJVdX5ijWbTBw+CaZptbP0TyKyeb7icWErkFFjlgurN7tGN?=
 =?us-ascii?Q?VSHeJCjTpg8OuaTMa+qLs82xJPX8kdKZaUwGeniC85du6zy6VHxyVRjUysQ6?=
 =?us-ascii?Q?vOxd1lTgcNcP1rSTSsNxGEpskHpcJYUej6xW2lodEdB7i4RnmC7PIMy1S3HS?=
 =?us-ascii?Q?gkmH25RpmHd9iUNMuv7i8i5DH6Xfm3uot+62adj19ZOKy+CFh1MX6lHHYtEF?=
 =?us-ascii?Q?oBLzBpCDIVIF+vzV8miMaLSqKRyfpd+ukAaGdFvL6PY29SfhNkm8ikBtYYcL?=
 =?us-ascii?Q?oo6uK8a51MTQfqK6xSP+lLAqC2j7f+stzQTbFT2OuGW+DL99Xnfzg1bODoOx?=
 =?us-ascii?Q?U4U23fGMQ3MNgRXIMHueXvhf9p1XPihJJKiqTpKexffZJrsRSxHaa6+6S4bO?=
 =?us-ascii?Q?Xk1JN7Q6Rm+UDvcG8dn25UR4jdl3yGR13s60kYLd0c7v9WMzr4Azwcog/4Wy?=
 =?us-ascii?Q?6arss6zV4Ik5uX0kdvPMHZa7vGsApnYLeybMv3HbTd5EcD8PuA/lC5Lq9dsy?=
 =?us-ascii?Q?M51IuTVBOcRbdLlgzxsq07Z3Ih8/kCqZVho6pPdkSCPn2vR5HmSsnfp+KZz0?=
 =?us-ascii?Q?hNoBtlXkLoVUVtdsBLQRtPiXKRiHY0ofh8opnJnj8bUsFERFhft7XgCkgmSh?=
 =?us-ascii?Q?T/xOjVZiM/Wucx8np+VSZzA588U89dijGDIWtLeIBywTbmbtzlPi82H81dTA?=
 =?us-ascii?Q?ZAHbPALcAWxf+IDE7oh0WqaviE3i+F/dg2MWmhfN+Zu2dE+RUYOwQyv16WVV?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6870b68b-56bf-43b9-6216-08dc964ae1f0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 01:45:54.3736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxORWlp2o1sWGfvlAMeRLMeKvUeK4s/qZVRVRxd5V/7yhPPSeRKWJUvaoqG7sAVBztUlo4CAarAcBh0lZZM4gbQa4cU1hvIScrQLfw015V0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7658
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Although cxl_trace_hpa() is used to populate TRACE EVENTs with HPA
> addresses, the work it performs is a DPA to HPA translation, not a
> trace. Rename it.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
