Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CD822C35C;
	Wed,  5 Feb 2025 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738752215; cv=fail; b=BEP5kvhCETpmoZMvjpMzFr6smZc7XR4tb+PeWZb+UgWxnN/+kW/GHRrYQOnMrEGorsOr7gtKix0r8qvALsq8VWmAdNaO1L4LQbqOkQnmhChS0L7luC3+cBzuNE05AkmWfZpWM8ye0B3hKIpA8isynsLHhCHRzy0wuraaZxGfc1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738752215; c=relaxed/simple;
	bh=3HyF4Fy2o53uvnRQNGURNvF3CoQfgXT8UHfxwL0IWH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SRwkHjlio+7t8PIuhjKJ6mtBBmuWvCryOilbM+jfbsRPFnzh+SKFSIqRnCVetiXVI2yfEh1lgmVCrCQSoOHiJzcDfjkpv2Rq0t1TkFyRR34SbC22EGtG+h3H/V7gNl65fNJVYVkKUxWs2iKpbUTat+4RYZBwHkZ50XxRFRzUMIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L6ONsiyY; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L6ONsiyY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHTjmVOl/vvMcMIzm2kFQ8rFTGAgE9rnEz93nodQQI3wm/yqoWSAI/F/8tm979IFBx5vO+wWQK0Z8VI6Jfk+5skkjEUwJiFXAR26iCgEMKsZ/4PqN6Zz9Bnk10XagqB3TV6WQz7T4KHJIpWdd+dqJ9CfFaljbKL2DefaJcdUYnLf0C/DyUWHr5eKeLobGCLzlx2HETy8bqQ82ZgVj19L7ZgYEnsRrGnS40PoRZpGrLUB/ffkQ5b9LgZneCMdqieA4OHHcQvckymPqxBTbrXGqwzX+K9YQGk8/IuAqGrMuh9NZUY9+oFZCLcjjf1M5/moazAX/Cga17fv/aTG8IbauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgaZuhJyKqFDusIhGENStPB8uqiJYKlHm0Z9NATKDYY=;
 b=fY57TIv383mVa78CD0NEAli2PLVMdncvdMOb3N2zrvFvhzA3+JfVrpp5Te6qJVu8sBFKDVqKCnTVd8UGw5ZzZGYIUoHkNOWls8LtttHeOX57MmT0msxW8lrx/+FndbaEaQ2dhrxx5ig29bG0Y/37tSquWeqr0hDzW++goKz5LaBkcUjv8ySHAuu3znszx5FGyNL33Gw+umPlJvNWT3AmVemi6mPs3ezLViGDRUNo9iwzoC/jxJNjEO9RD9AQkaoVN65iK0p+nkCMl46DzbKZt+Ld+yJAEoRJLbvYhcS/Lto6V4gK3QED+kl61fbDFpEev5AYXaaehFjSU6bCS+nugQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgaZuhJyKqFDusIhGENStPB8uqiJYKlHm0Z9NATKDYY=;
 b=L6ONsiyYiaXjp1KNMeWh0fp8wevKqAWyM8UdnbdNJS4wiD2ehA8vbXqCkxgMNAggtDDMD2qI/h/ZujrFD2SP7c5O2iaXQCwUeL5Yv4oEp4743glfGAo26+aCpSIGv8ZFBQjtTM7Sh+59vJi3m72rb68McYFMLSQOcXUI2T1t784=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:43:29 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 10:43:29 +0000
Date: Wed, 5 Feb 2025 11:43:23 +0100
From: Robert Richter <rrichter@amd.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v1 16/29] cxl/region: Use translated HPA ranges to
 calculate the endpoint position
Message-ID: <Z6NAyyyGzMJFJuDH@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-17-rrichter@amd.com>
 <27808223-4424-45ed-ba63-cc2b5f80a983@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27808223-4424-45ed-ba63-cc2b5f80a983@amd.com>
X-ClientProxiedBy: FR0P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::15) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: d39df140-76c4-4ca0-50bd-08dd45d1edd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xfw7EfvOb7sk4Oh2O87IkR2hQFdwNedpA6jU2thCoYapRjcxm0EB3BLioGvo?=
 =?us-ascii?Q?JdcmRirYEydYkBD+obAc3aLq+2pWBzo1/acPNxWzR8JDClLocHIvHkmlGQ+2?=
 =?us-ascii?Q?A4Im6iBfGc6s1Bw7/kxLCWM8rj6Y7xEo+odbiUN75x5tJomHH9EwbNBMRBD7?=
 =?us-ascii?Q?cqUjlTYKkfIHqITqOtAUXZpsK6Lhz14HEvzDItCE9D0G2xwmwdaFH/92aclV?=
 =?us-ascii?Q?fe+bSaJvdsPrH03jOZJc+Xz0kAaDZiUu8JBDxTFkBmTstOGTE0w2P+nNKtfl?=
 =?us-ascii?Q?qo0+Trfp71R29TmsGahv2qzL16pa2le8Smz9QAO81wnHqKssJKeLJFwBCsnT?=
 =?us-ascii?Q?EU6/7r+TzYd+W0ni4zIhuGS+weNRYS6XL/BI/WoxEApgcUlt3dScldM3Zgsa?=
 =?us-ascii?Q?HvzN7+bAqbJ0OmU5yt1+zMFsNuAUiNx5MQZSDx8r17nQksWFsPcAAV9iXZfz?=
 =?us-ascii?Q?TjSvADHLWC6X5m+7VMGg0Wopm2DdAhBx6LWZwbJJQh4pgZzbttSX5ZRkUVm8?=
 =?us-ascii?Q?hECgpAZJd6K7oAiXkPnjHWbiT0zdce1bFqMKh/QLkDit4fcUinVFYQcb3Egf?=
 =?us-ascii?Q?A6YDYC9DU5H5AG6QH0pWyaexPLlLAiru0nfuNz7tvGkVIit5tSO3OHRP8zs+?=
 =?us-ascii?Q?BtVbm8T1ApAi50TP1nPC663OkAZuJVxkBTLShPBMcoOWkg4SeDadmHSp7/qL?=
 =?us-ascii?Q?xVmcqqhQ8Fw/Xx1BmIjgEjCYD6w2kEh8Sa/ea881N6QARBIjStnkwtpNVnp+?=
 =?us-ascii?Q?tBF8mJVs5XufvbJCBNfgAh/USPggrmsvDlaWLLXZRXnflmS4KYUAtLlLGk/C?=
 =?us-ascii?Q?1oNlh5ZiXm79hwMcaJ+85YQ9rOucCf3DDUQivgRoljXsOlqtkf0JPn744+Rb?=
 =?us-ascii?Q?u4XJRvwDd0XHdkKqz0mx5bX2ESu7WdpF5jBCC0zDc5LBclK/ljlrvoVBOqph?=
 =?us-ascii?Q?VOpUrUo4zDxl39z8T492jFiJrrN1CeJ0fjoSVXgBmnkVGPrk/mkc5CPZnWqM?=
 =?us-ascii?Q?vhpKfaZ3kYWQNfPtYl8SJICZ7sGwSM59rA9cqQtSSpv4iKjNEAoLRb/kS9wr?=
 =?us-ascii?Q?Zg0T90duM7W7n8bKT13NuAx8UdBXfMZcKNYDSCWdYGYEyXgYeJHerfWucMcd?=
 =?us-ascii?Q?LQ+IDIXdoUfjkZSNQIM70sIymf9J2zVzu5VxB0A77dX7ZY0PyCwYDwjZ5b4S?=
 =?us-ascii?Q?nGptF74gFUQOu45WD5MQLunEKRu4BGToePczwiBlzx06OvIJUs9ZP+abhBEl?=
 =?us-ascii?Q?eic4qCFZZvcfBF3HfCg7PlrC9KiZzwz2i1WXIcH68bdbHi6/WpaC9svEqWly?=
 =?us-ascii?Q?xyBwA/O41nUSJxugoierqxP0dR7zmIuUnrHqF+/KNPAHMzhD+jTRQ/WWdBMr?=
 =?us-ascii?Q?0kl9dnbxsikoKIaFAyBUCl67OSTj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sbF9zjXKjqPxZTXLfLCMoqoL8SzX3Xgj1M4UHX+VxIpVewDYL7jDr6yuC5R4?=
 =?us-ascii?Q?eUoAEzQhfGNvSJTK+ZAJRGPkOP6FAHV3QAhD19UY4xqClzD5cYVhgj8PlQQm?=
 =?us-ascii?Q?dnUHMRm7X/ySXO3YarizJ083CHInj4Z7H4T63Gf8SqmuKi/DXdhOMfJswtlO?=
 =?us-ascii?Q?SAchTX6sovsjK69w3XtvVKroZLJZYcUiSZXNhyQvlVF/i89+/Ppc8lNPjez7?=
 =?us-ascii?Q?tnnj5LOYZVBz72nFo8HtqHF48bBa7OWK2TUMKhADmVe6TApSZ68InGteEcKb?=
 =?us-ascii?Q?mfvcf+in8U5IjBZ36SJclsZ5tcnpSt+lPElXS8QH4U0Dh8V20tNP6X9qa+Fq?=
 =?us-ascii?Q?C1D9l7IGIOhbZZxatOB4aQoed4r8t/4qtctJ+ftAYhXGiP3AvYLejMrKdv9m?=
 =?us-ascii?Q?6RFUeo9bh+Zp/ry/yNAFyaIGbXQGQ1zxuH22Y71oet8I64OrDr/JVHypopyp?=
 =?us-ascii?Q?lJQM48xL47toV9Lxt0Xy7TIfjtDeuXQXD4c6dwkWL/1EgVrJXeZChIEnjUTO?=
 =?us-ascii?Q?qYNmGfv1sYWw2mWovSaT7Fm4aLuZI9BOGsMGyw9QKX1yhtfneJRLzwFCj+73?=
 =?us-ascii?Q?4+kvYsS7pwMovPs2Oh0kKW5KrHMrAwegPJcc7nylYpY9PYG4mPzkpNsGXohq?=
 =?us-ascii?Q?NQY1Pc4DVf0LpabpumTIFZNtyrkyi+VmfSzHBX4Dp1nC+I6wVlKLm7/tfoiZ?=
 =?us-ascii?Q?mMDqlCny3wV0co6VqTBBWIcyHdegGOaYkL3yfcIqGOQsHSjOSFr0GJ2vAMPO?=
 =?us-ascii?Q?zfATJXA0tvMwe3v+IuW3kwl4nMe6hlIeOlyqlVSofbvw/dMlMqE7Y+hndoKZ?=
 =?us-ascii?Q?Ip25qHqMK2dXPl1aNPQlogkMPuHCcsleeUr3Qw0Qm6PlHiYPpBmhd95ya8v0?=
 =?us-ascii?Q?jODkHELosX9niKZL2XhT4XKyCeM6YLb8LEIdr/popipB5kv1xbMJeilBZfnI?=
 =?us-ascii?Q?ZZ7gQjlzd3CCsGKF9nSSJUIIQhP+JyfvQ8DJKXsMw9yOWGlaY4vZTt1CGiQi?=
 =?us-ascii?Q?XqT1cKQ4/W1a+TXpFl8lqm1Zq7IlG8beseP3GPVL8fbgfiApZSw9GtPZxsRU?=
 =?us-ascii?Q?uoGAidc8i/VCdZWiNEIDj4MpmFi/T2YHMlKpkaoPFHr0v7Pg9Ve7hZErTOT9?=
 =?us-ascii?Q?QzY+djkR4H+1PyGZQKzzwpfViQznwEicWIYUGRAmVgOLsBgiWBZV5BjT1Lni?=
 =?us-ascii?Q?XiySDaFUB+bV+kIkOujGGPXwARaarRB4HOHFaz9Hlv+Idg2V6Lcyn5fjdNrS?=
 =?us-ascii?Q?Ua3e47tT72Oe2veLgra5HsuFiaNsAiNe1qfu8/ZMmyvMy3EhcXCRKOyfPLKT?=
 =?us-ascii?Q?EJGYP4yZG90BGxoRnERkkEimVH31yuv4NRROZFLlqugJ73IV9Po04fsPCql4?=
 =?us-ascii?Q?4NBhZQpfk1YHilT+1hjjBDkAu3aV6QDIyiRu5j5phWv/5MmO9gOhqKqXgIq8?=
 =?us-ascii?Q?cLlGqOLgPYUqNojE+WWhSDP7D7eud9kmkkUcwsUXle5l151WJ4NeskX5MhtZ?=
 =?us-ascii?Q?4ZioQ+JYu6H3om5IrFeiID9YfKw7XKAfStS7N4koKDcwLnQHqZdWWdWmXTGH?=
 =?us-ascii?Q?J4zYiYAqbPVQl+Y1S6c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39df140-76c4-4ca0-50bd-08dd45d1edd1
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:43:29.7937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6YNzOlHN2nnNQ0hpSBVGQjthZoM5P91RNlZhM7aVoNodt9xabi3wd6ZAcUanb+c2lV9X57Iqq5cyTEJZuLFoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166

On 17.01.25 15:31:48, Ben Cheatham wrote:
> On 1/7/25 8:10 AM, Robert Richter wrote:
> > To enable address translation, the calculation of the endpoint
> > position must use translated HPA ranges. The function
> > cxl_endpoint_initialize() already uses translation which could be
> > reused to calculate the endpoint position.
> > 
> > Use translated HPA address ranges for the calculation of endpoint
> 
> s/HPA address ranges/HPA ranges/
> 
> > position by moving it to cxl_endpoint_initialize(). Create a function
> > cxl_port_calc_pos() for use in the iterator there, but keep a
> > simplified version of cxl_calc_interleave_pos() for the
> > non-auto-discovery code path without address translation since it is
> > not support there.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/region.c | 66 ++++++++++++++++++++++++++-------------
> >  1 file changed, 44 insertions(+), 22 deletions(-)

Updated all the wording, thanks.

-Robert
