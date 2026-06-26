Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0500837B020
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jun 2026 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487281; cv=fail; b=kag/BhmbtnCxQlAtoz58m9d/PNilDvur0YmeAiBp77k9fn0FxVgX/bsqBl5TV1n6NO4f6aTwlVohiMqrlSHuIWjYJqjQcyD8HyKkAPOM7BCxBJsBXRya2oH7IQtZqsFZjgHS4FNrk8vjF9lZTBFR/Jtv5/mHSBcDnFWLKaGK5uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487281; c=relaxed/simple;
	bh=LBhbRBrWToFkmM90hAMcgXzgZyYWYK/cWJosLIbN+Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HFiVD1bmjWau3fCXUPrGrGO7ogv/m8uNvCvEpSY75e8cpVOz5G9nFYp/9ZhIkG8/Q9y8dEcUecjtC5i6eU1QlByYXn51A+pWx+CRVnwNgPxD+CXGDS6axCoiClHVAoFYCHz+QhPJ8hbJVFT84j7eJBVQS3hjdgMKGDUv6mix5oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ykBd2x2p; arc=fail smtp.client-ip=52.101.61.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ykBd2x2p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJIQ6vjXJaQPGkBi6bBijLyKVkwicnp+CsAdUtZuxtdNMJlioDyD6f45kqSHxJBrwcIdqUidwy+aeAHJDkbH+95hoXhasmQk7NPmnnYytnwRhXD80KiJ/83QOOu2UBsc31gB7Q1o/PSXyNOnK0VAvGjMMTGPbF/gEeX3TR6RhFqBeVaGAcIS87FF0xWd2jRLg/TsNqJ7T5uvUBSN1p4mReEUDNebwz7VaZVAU9dh4syoRvFJIkuc3aXauZMzEyFUTEIk58mDLbO53VQJTSSumkNUiP1j3K4eIcuc9iU94+c+n3EQS4Y2b/t/0jcl6Bass5k2Z0SphMwsTWhUCRZZ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+hLkEITCQFmrn8vLmQpo4j06eesTu56nxh5C0itNZY=;
 b=J72aie/6d58/1EishJUOyqKdTqjleL4nmLD0vF3Xb7Nsh28w0tzNW92fSCUO+/Ch98cXGFpINJu/cp3nVAY8uPeacCfeYpVsuqAaLTaimydDSFIKMUsRCQMTxx/0CM3XuU+yRFTx38j2DBSRRFZsZ4xeyXRDHjhFqWpyuzpDGvQ88rjAd/8mQOfrJZXsMu0kY+1cOf9k8f4aWOBarTINEvSrBe8t+VULejff1bWyKQ6AtK6a+4GjC2Z0JgeZwpE7gsIwtsjzHm2byYahKrUpzoTfcicD4Fm1blXWmqwrwZa+21ObpUVxGaTL2eDZFql/iTX3r0E/LA2KKfJkC76I0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+hLkEITCQFmrn8vLmQpo4j06eesTu56nxh5C0itNZY=;
 b=ykBd2x2preQrYFCZbGfOXczLs2GW2kBn4ZcY+IP8pRK+C0CTs92Wo69Ewhm/Z8LoNTvwI8VB2q9Z6fjMckKVW6Z6fppuYE0YjhXEQdGRBQdOeQxXx5qSOCMTmaclc1MBAHjtVMmFKmUp22/AYjqfy1rEKoxJ09uJyqgG8aLu6XU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14)
 by LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Fri, 26 Jun
 2026 15:21:16 +0000
Received: from SJ1PR12MB6074.namprd12.prod.outlook.com
 ([fe80::3dee:b690:a008:1bf5]) by SJ1PR12MB6074.namprd12.prod.outlook.com
 ([fe80::3dee:b690:a008:1bf5%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 15:21:12 +0000
Date: Fri, 26 Jun 2026 17:21:05 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/6] cxl/region: Validate interleave selector bits
Message-ID: <aj6Y4VLUdPjF-pAP@rric.localdomain>
References: <cover.1781199122.git.alison.schofield@intel.com>
 <5ac370e484caeb49c334d5a586a7ec8fc1b3dc38.1781199122.git.alison.schofield@intel.com>
 <aj5kbdsqLPge-rkT@rric.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj5kbdsqLPge-rkT@rric.localdomain>
X-ClientProxiedBy: CPBP307CA0019.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:2::7)
 To SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6074:EE_|LV3PR12MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: fea2c6c2-9296-491f-eb3f-08ded3968e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|56012099006|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	+PzAEWI1Jt/H7wh82nh9Y0luGgoB7diQSE3f+Gp6hpYI5W8gfEfrJvcJkdnOgHYaZ1P54M04SmIF5dVJjzaHbGTeG3JnXjHCmM6VqLTE0nVLFXtmNClyiL1dbko55kEwdXRVMkffNs2kmBpiT1LbigFMQWzgZIl595Mbs4UfGpe2Jfk46kUECLR5ZDWp64+Qp34M9ssGkuGgNtKbzvM98+6esTT+Fw/minC27SDXnk7VjxaL0woFyN2VOJvkBlYeEcDIMfuVKgeBpc3FjZ9BOZv2LwiyKCGcMoGl5QeU7AW2941qfWY0+ESNA/XQK36IQaJSucVZjcKaTSXkkQdS18+rZNMDTq8wqR0kdMqAnIVkAXG1FNRLzGxUCXUCezXetOaT9tBeYHVIdHhEhsU2N6L2BSbpOcfXXs1RuqZ0kXqCjhb8wodworuvEmuhyA2p2Xb3IfU7QJn003xl1HNsS7ABHuHBCFfuLhLcbnryBWM3LB0V3GautxstPEC9HICGgqh5EWjxm22TWUnu9sSmQxpIWVf8ksO/+9rWg5I0GxYf9RSoPuk1rKtFZViJL06Kj4PBcLRNENm4yy0W5z8ElQbOVsBuys8GgN9ZK4fAymlxLc+cCtw7/Fz64MmU2QtwIhCJKAxS5p4GR15u6FJ2FfGBiZzXCwWyoyIVwMHBvZM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6074.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(56012099006)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eol2yE5TM6evrxQY6cF48l+9wnOu1i9WSw8stoC5+W3QVRjhTEYgdvqIosIk?=
 =?us-ascii?Q?k/6yT0+2AYeWkU9ljBnLM8/fJVwCuIOQvb9G2CQonZ5knbw9jJNMsuB3fDE1?=
 =?us-ascii?Q?Ycbvbe1W8wnHB9xDAEW0r2jFvhBGi5HSz8bvz0f3Rn8/nmbGSJRkjZ7pONWr?=
 =?us-ascii?Q?rFrnW5sQ3PHKokIavd/NcBbPhW6MPMDixQ5KjRG+7jJffE/qFwpn3D2l4CfE?=
 =?us-ascii?Q?tEHrqxLcgPCNK+BYC9+cv7ljQKd3XJXJJOug81zZEdhVDwtDloxJ+LWKP7Tv?=
 =?us-ascii?Q?iUqt3wsF8o1fxHyMmB09R+zeSa/drG6vmavvTn24nBlz2EH3rnXlxH5hjY/t?=
 =?us-ascii?Q?ACGBnxCh0uh9at0YDa62Zl3zmTeMv3bwAYIbMQW07eLwrifNTcrcsV0TdtxP?=
 =?us-ascii?Q?MY3pNa43VXF4ZP8BBWJtGEtV8G3ZQ2xz02s6VqFkRXaywPRK6SE7U1cFOf4Z?=
 =?us-ascii?Q?Dnt7MngjX0Ve2/hNWIpVgGmghfe2YTidhsBuMPjmMU3JGEOao+Cb4ZXXY8Rt?=
 =?us-ascii?Q?ynd4mTxeLMg4Zel6wqMZZkYM2nueDNJDCsSXdMrfdxI29aB1p1Kbx4MdSfP+?=
 =?us-ascii?Q?Alpu6x7KHYL5d+P4Mi09EsHzRA4+zESHSksilqqoByLeUmklruqFloiC8xoL?=
 =?us-ascii?Q?rz+dEFbaomfT7bZkEY0pKj/CImwN7EclBhv38KZnXwLaxueA05geOG0ANU/d?=
 =?us-ascii?Q?5wXe04f1YOrUDrWJki69VwDM/CKAa8CyhNLJ64+JIxkIqm27bHSqM/kvKLip?=
 =?us-ascii?Q?7lKm/xg2rUI4mUyJdIGY6Rh0Opf74FObJPxZe/2GgO8fQQReo35N/lWXDfEn?=
 =?us-ascii?Q?Rd+GIy9KENGUiHWT6oSC+R6/g93cQWHwb26nFehuYmYIuA3UcRrp+q2R7wQz?=
 =?us-ascii?Q?zngeom91Q4vYW2yOkBpbEtjUFzbt9cKggaRVr6n7DP5sL/XoRRwF8B4K1Lts?=
 =?us-ascii?Q?uwrhPpX4+j7LGkZNyKXD45ytdfHdOnmBp84er8pEYjSvHZGPwsGIErZJ0TOj?=
 =?us-ascii?Q?MYBWM4fVTt0aOmcJAH39pWRZLcAyMbmquxc1F9GayMUUGuApFDKbubMv+2NM?=
 =?us-ascii?Q?va6Rm/TKm8mS3BuG8vdDtfaLtHHUh4xVUpYN2mCJU7ctKsOVwjSgR4hMFWLM?=
 =?us-ascii?Q?8slylQSh+jfJajnNwP/YDNzeALMhrjN9xQt/cK2J6nLlN5OY2iXrYGbPA4Bj?=
 =?us-ascii?Q?RcBX+ybHG4K4LThDkdGZVue3lPbF6mGNZJDytt3tAF6wch/4byGnW7ueA1dz?=
 =?us-ascii?Q?B0NspLmxl6VVvNAUh6jBp0TJAK4lrRPciou3gfTMKi0UmxFltReud2Tt147g?=
 =?us-ascii?Q?vDxe81FeQvqvCOHVRTBhKvJrVTMSFCuvVrPz+DHftGkeFUBxrVRsmoy5BjTC?=
 =?us-ascii?Q?ENGlxB7OVSBpNPzg9QuepqJ+Ba8He2jiKA86Ci/V7O03//SU4A57YO8NqDF9?=
 =?us-ascii?Q?pvZRJMR/SGlYtroAT0J1VCEpnZ1AZ/P/K0IOGq3teZj1uzTaMXBl7UUP8v8J?=
 =?us-ascii?Q?ilZFxEooLkJ2oI7dS/VL6zpI+p9HGTzoMKs0QM1F80G5krzxAhpQNZZzZ5Ed?=
 =?us-ascii?Q?tE/6OQpfzeu9FIj/mr79dxbh6N3rxPnLT9gg9fNV9d4mJfrTFv0PYLAM7Row?=
 =?us-ascii?Q?tqx/Z2ZOOl7xejT6/4XGPrESXrk4KTe8XQAeUkeHJktPXQW5okEK1Ec1YAN4?=
 =?us-ascii?Q?Nh44z9T9hatvGdi8Yh86XBSnGxQt5Z3KV1spv2aLzQv5UkzO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea2c6c2-9296-491f-eb3f-08ded3968e44
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 15:21:12.4683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHPqWAsUL20r9HOLVp+QV8wNgLGLTcswLT/JdEbA8TKpwxXc0qGpM7QIR4oEChbl79b1t7ygmaLs9xOigucZsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233

On 26.06.26 13:37:22, Robert Richter wrote:
> On 11.06.26 10:47:25, Alison Schofield wrote:

> > @@ -2067,6 +2062,11 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >  		return -ENXIO;
> >  	}
> >  
> > +	/* Keep this patch bisectable until position arithmetic is updated */
> > +	if (cxlrd->cxlsd.cxld.interleave_granularity >
> > +	    p->interleave_granularity)
> > +		return -ENXIO;
> > +
> 
> Hmm, that looks odd, even if it's only temporary. Could you explain
> why that is needed here.

Ok, I missed the point that the iterator stops at !is_cxl_root(iter)
and thus does not consider the cfmws interleaving configs of the root
decoders here, which are not part of the parent selector bit mask
then.

That creates a 4th selector bit mask for the root decoders to keep
track of. With that added I think all the stride handling in patch #3
to calculate the endpoint positions can be simplified.

-Robert
