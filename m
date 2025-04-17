Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654D41F463D;
	Thu, 17 Apr 2025 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895478; cv=fail; b=W7uA7FlNxSxnwF9i853rdQCfiwowI6ql7+RWtmaVTdgcUcEB5e2YA3kNdYPlR9xhGvoqxx4XVLfMPKyTXOpoTOzQ3v2/3pm62IL/wNagPyB8AL7TAWX30ueynGANC2dr58TFMGEWhvHyW51WXhxACzvpCAflFO49/kYMav0L2dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895478; c=relaxed/simple;
	bh=cXSNLCXzM3yosOUF99qGhUmL1XG8r6WhGDUeLLGoW64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OowVk4xL/Wt86aFNeyq006i/ErRJ/LGHEy3C2q8lzNtiK4mRrNNjLIi1myTYloVMsd3nMmqNLFb5TuqlvZvSWMBxIswEOSJa8FSr7yox0PtCEr3PS8APLUbHcfYH5IyHZMWShdN7xAU3N2dxlgNV84bkTt2wAiSCKnLCVii87ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iT9w87VE; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iT9w87VE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txVml3RFxWQEkZ59ZNjfdOI4vd1P5g5Ncy15m/T82aNi2BUyvDE6atDDDgUt1NOx8htjwbYd8kBTd4sjWkMAQMA3mN0I/IhJACQjiY52c3E0n/Zgv7rZKsOGkHmhlNQYffAO4VErNf2nABhp6R7ZJ6wiQc9n3VoNAT5Sf65B4FUhwcgqVw5W7VKcctwkaBSHeShp78QtiHgl3fmk3WBlvsLpTsEc98U9w/ShWv6QBzG4YGpxFJ5k+HyXO8LK5ujMOG8EoWF8wI1UHjv33CU4joD8nJ3m6ksVpJikzYGctxMGeWoaIitrTNZ7m7qsFhHc3CrROKZvHaXRrc9msf+59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dInmWQEHRcAeA1nAEFZyvb0o3sY2npb/+Rndpnmyuu4=;
 b=VdT9AmiX7Oec8J9B1aGozu8MR223qDY9VkzWjLYvvJMspYbE7unsvA2xu+AuY8XiDQ/9j88Mh1htoyFgzSRX4lKQDDcUnMHnYmtceadmG9pxdaX4nByx84FvH94+P+3nl+6sNJ16gQbHU8gCZ+Cm+mvUc7oRdL+gDMQZPwHrQuLiqsxKj4cKeIsOCUEc+A/6Mrh1NIy5xt3ur8guPcG5XgYoZkRxsUnIvulWeRQ8Ze3ZQgbg9KTdVoavV71qd8oGesw9ZEhC6y0NUZ4dIBByRf/YxOyVsG3FgXoppe59g3FRcKgSaBKoyQa0FWxGg90mTIscfkhq8zuScFollPK8tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dInmWQEHRcAeA1nAEFZyvb0o3sY2npb/+Rndpnmyuu4=;
 b=iT9w87VEv4cs+48ppwnTwchquk+QhuQr20d7fOH45fxBeHG1aFYyDEqsvWCv19f0PZXJ6Xio6xXn9XLW402sgUJTUZWf56Og9GmORb04jGpZ/HyErtXk2kw7UKYVxRUBGXtH3sThoHVOni4/zFNJhWk3O276Y9bXSfovnJWR2e8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by PH8PR12MB6698.namprd12.prod.outlook.com (2603:10b6:510:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 13:11:12 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 13:11:12 +0000
Date: Thu, 17 Apr 2025 15:11:06 +0200
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
Subject: Re: [PATCH v4 03/14] cxl/pci: Add comments to cxl_hdm_decode_init()
Message-ID: <aAD96vV3eSb481pM@rric.localdomain>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-4-rrichter@amd.com>
 <20250314113337.000054b6@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314113337.000054b6@huawei.com>
X-ClientProxiedBy: FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23)
 To CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|PH8PR12MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff89eed-d164-4399-cdec-08dd7db153ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c30dUn36DQQ0efeUaJayJwiMwnAayvG2LWrXuTbbsy6FP68r8ye/d20NgpDc?=
 =?us-ascii?Q?d3RFgfoCoq+cYMuFv/X3XlSIM5LTIdXP8wye5WE/0zeY1rSs4lD1RatdeYp4?=
 =?us-ascii?Q?vNATdgUmF6b2wy6r1WywUJl3q9tBzSooe7gZkY5dArGMdPLdGDz21qiUYsi7?=
 =?us-ascii?Q?S8JLAO8ja4AbVD6qJB7UVG1iy046CNdMWdnWelMsga3mlw0yAxvPj9GWjGEr?=
 =?us-ascii?Q?YxxrTmUyelce6bmS35DHtN0lQKfOdV3jbTKX2m3Hnd7VZVM3Ogm5Eww0CkLK?=
 =?us-ascii?Q?Ff+lLxfGAUyMvFuVGzmasNQP/BBIf8YUbiAs6S87KgFKHZInTLsJP8ZMfoqm?=
 =?us-ascii?Q?FkN8V1NNjD3yoRUIxqyZsofPm7VZ7kdtIU41o46bOH0iaLn7zrclqYOfEbTO?=
 =?us-ascii?Q?0qfB592pd5MyMZZKTh+uywZKQC7uhdkKikP9eLXHSeZ3rv7jGVwa1TJk4qXE?=
 =?us-ascii?Q?ul3L6LmAb51lajZutu0X/gNTYX2+gHlw1wxt8DupZ+niW1UnBjcXEl6unRU/?=
 =?us-ascii?Q?XJdc19XpLR3KYgd/9Nvb7Bk2T+Hfku/5l9qAB6SMVb7fUaqhYhIhNY/TB465?=
 =?us-ascii?Q?0JZXUTcZVDrGZuM0oVqYtok/IBO5wNtTO7P3vL6TZqnNGXpVE5mtBT8EvNW1?=
 =?us-ascii?Q?uLEZGzJ5x92VJJ1U9Ev7SDbV5gZgiHy+Hn3ScLxmXE0UnvlUpSA2yZovm8yP?=
 =?us-ascii?Q?7y3R2l/FY+z+zlm4pkScb38XMAPAtjfYwsOyd298kXVEApVBSAPzBtMnZtiv?=
 =?us-ascii?Q?dDd8lNTW2vZP9F9EppPUL94lvzGeJ7CyQ8tIC3bkvJQn/JC9IF8QzH/0SnUv?=
 =?us-ascii?Q?R8HQddbQWsTaAFMGQJercmdaOoJcs/RBQU6BUBP7jiMCWnUP6/DSnp1wt6Zo?=
 =?us-ascii?Q?uPt0oGbqTvQ+PCZSJVaMumLA+nMawn3xoe4c1JcAm4Np3qG97cKbElq4+Dg7?=
 =?us-ascii?Q?Gwa/qRmB8dqNLnXVKSDWjZzoq8vy2GWccR51efGSF4icgfh3JD6uxyZYNtbZ?=
 =?us-ascii?Q?yCDWmsFH3+n3kIPLTDuO1m9RDaLeyyyevdYN5YCunwVwp/+V0crMzjcDjvIf?=
 =?us-ascii?Q?W0wzt2hwjQrX3wewV9k13BGuMicgbkZmCVajHwhM3XJZELin/Wz4Gh8EosRu?=
 =?us-ascii?Q?a/2kost4XPfAQMi8r9tqNQ7Igq1/JMaEjnbPOxCTkyiDPrhXAaBy1ZaXnyzb?=
 =?us-ascii?Q?sYlSc3UrsmY5y5mc5lm4dKR4A4+naP0ppalUQYMHlKdHdLpXjdPpbuQPgxbu?=
 =?us-ascii?Q?9sDlJQRNOa4KUxGzGKADkW/cofY1yq6loh/bYIU8sJhAc0kxcuQrVLBRfFzP?=
 =?us-ascii?Q?mhkAH81fXZH89SyMhzN12sdp34Rz6z1+kQJUA0XAYx+og3uIx6J6VzcfUskw?=
 =?us-ascii?Q?LRQgkKF2/Jp2b8UQgvFEH6v4nha0VComLLIZG0me52YojAj74h0HwWz7cNby?=
 =?us-ascii?Q?txv22CsjWSs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BFEGYZ8UNoBVqZ7JMzII5apKZvUl6ExwrvgM9k4+4siIdXK5g+kjjnhSaXB3?=
 =?us-ascii?Q?BUbFAX48XKwl7Qf1InVkRJG/Q5EsA2G1ue/B8uD+tPM2/qwl/uYBeccHqfSO?=
 =?us-ascii?Q?luuP3yFsClR+HuCQf82Ny9l/VNPHXxqKSOIOdTCELRTUketVTQ2f96jQC/ER?=
 =?us-ascii?Q?Ad3UMDlNvrkRImxXxjPkW+pnDAEbLLJ1J4q08HN0pzH3NGKfouvDLhGiJ94U?=
 =?us-ascii?Q?oGw/LMgecNt3O1IykliUl45hKNG17aBWeYEiDPFzDDjSCbpigJXtOjyeYr8q?=
 =?us-ascii?Q?2U8Z/+YX5e6vUe4+eaZ3mbx3S7WopC/mkRBHXltOG5FPMgoz2MyKttwaTtly?=
 =?us-ascii?Q?ySjaS65TMOVrcSSs2JT5h2nX8XpwPbAbv3kBlPftvytv7X9PJYdP+loZRqJ7?=
 =?us-ascii?Q?2NDcCsJhaB9M2bzBO+fsyjOwyXNZCKMu75x/uK9f/OIuuiWBPxdIsVyVGyPR?=
 =?us-ascii?Q?Vd5JQfwcOxdFaOSIYsG+p28INu+H32b2haLUHr++1wlPsxIL40u5ZtEgwYj/?=
 =?us-ascii?Q?X+8KXfzJ3edJBfEpye9SW2A/y94BQfsmYLzNec8Xe8RKQBnxv700GtmxpioS?=
 =?us-ascii?Q?XiOeymhP4+f+xwfan4vPFsQ6U/ANNGtJdEkAU+KQyMYoiOHFtQzxYBQASjzv?=
 =?us-ascii?Q?+ndj8PZuOF/tnBFY0+SWtdgcediBEl05fppogpA7/KIUemKMh7FT8EoxZg4F?=
 =?us-ascii?Q?5RHT0vDuaDIKNEjs4et4fqCGiVP57eFevbthnK4eHQAXmQbBITVcLMN9oPth?=
 =?us-ascii?Q?pqBKmLndpxZ99YPOqrnY3EOiRMpRhIZzCqrBaC7cWSQdfhigCTqDo9zaOTW1?=
 =?us-ascii?Q?C37p+5ot5bRCjVAWMH2brEyyMjLBgCYaLddMCM+ePYSGzz6eht9Y7NZ7m7Ol?=
 =?us-ascii?Q?qVUOuYTOH1y1uXGv/e4B7CTITGCIOggBTH+/G5NLzbA16r72t+6ZQtbdtBe/?=
 =?us-ascii?Q?fpouKpTWM+gF9dRlrDens5TwIOwB1n99B4QijlWSF1+XbPfDWbbC1ROeZx34?=
 =?us-ascii?Q?RqKzcQv2e+LmDthZWfPbn4FxPjNoYcUPMEdJS7pEhic+xi+rLNl+YwEn0nU8?=
 =?us-ascii?Q?cRV8jneuyrTS3HmyQ7QShIG84VvOL++fh7VoJReK9f2+B8/6/SHn0VZTL27N?=
 =?us-ascii?Q?U3Gy1AnTbcR71aY2dl1f2DdRFrauF2nB8/FESZ+RoWdVgN8+u5fXBkMJHRrd?=
 =?us-ascii?Q?qAW1FBVFGVNweQZ2Bri2Zw8qXpD7ujhnJTxc52HRgh4fiqQzABAE6zXsVa+i?=
 =?us-ascii?Q?kYUfGVRFr+awkcvnLKap7hdjPYNQq2vrRWrjKAkirpSkK6w1PeR4fUsm62GR?=
 =?us-ascii?Q?3ebbv41YTpbVAFJEcjxzqis3QFP0w45J2D2686sAipH3crxhI8ARlCkcEhiT?=
 =?us-ascii?Q?acljuf1K76YfFeQGzf/WqUyNITEFhrlowaEz3zwDW05hBcAaS87suCqmjAx9?=
 =?us-ascii?Q?uUn5ThlEaoCGjBYdX7JBl3uNnAZIQSZojCTQ2Y7iKfQZbn5VtMRdDPT0EG8S?=
 =?us-ascii?Q?oLzpYMQiWJ8ygBoHHAcSjH71LyYqw2e9zADPKGcKGxjm6VaINi25nRepL7sG?=
 =?us-ascii?Q?veF643b5GnRby3VdzxHF9qFc9vhu+8uoYxVyEYBv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff89eed-d164-4399-cdec-08dd7db153ac
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 13:11:12.6053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJePOCioUOj/yjloQ2HXwWhC2O3IaAMzf0fSxxU2rVLnKJzPWBjCZsh1pAcRMu/huN8043cDs95KZE3I2rp8AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698

On 14.03.25 11:33:37, Jonathan Cameron wrote:
> On Thu, 6 Mar 2025 17:44:37 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
> > There are various configuration cases of HDM decoder registers causing
> > different code paths. Add comments to cxl_hdm_decode_init() to better
> > explain them.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Tested-by: Gregory Price <gourry@gourry.net>
> Trivial comment inline.
> Otherwise I think this is fine.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> > +	/*
> > +	 * The HDM Decoder Capability exists but is globally disabled.
> 
> Single line comment syntax appropriate here.
> 
> > +	 */

Changed that.

Thanks for review.

-Robert
