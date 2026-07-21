Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90433E8C55
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626426; cv=fail; b=NoMe3DzuP1vqITLclTzDsgIfE5ZY8+tXa6fsR73BiY+6Fx5fpXFRX8cBmEVVeqyr8MtQ1HMFDulgNIxgs88DclVKYSFdiOthjmTI/ydCNx1ddyEx1sE2uh4++WiZzcW3MiBE+WTsQJLxlAaiYERCTPNTh9WNwkslQP5gQ7u0/ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626426; c=relaxed/simple;
	bh=dmUhHLT3DLDrZv8QmsY3wwD+dp3Vcz+IsuOsNmLerFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xj5xr7MnJ8alWE9fVorQG7+Fhg9h0+naPo1bOsT0RdZmDH0WIRSW6bPVrZMM9ja5tQirXPnqDuKD4TzXjLvPmVR5lV39xeh3RaT+0TZWtCMqkT3LfY/LQzx/J0VQxfEMQEskYoIwN4np1OzDefSlXt8g2SwYNp/imDmlAwI1ZY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hGXJkUYh reason="signature verification failed"; arc=fail smtp.client-ip=40.93.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hGXJkUYh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/1xd6AYThZz2UuDfcuccvBG036fFKaCSiLViK4WTs1u/GcIONfSdmNs+DvnIh+LLJREjcNwqNvwEGby1CReBBiNsc+4beXVGEHvUtUKh1oRC2e/rDFz+YCrWmFz4yPXM6c7xVcUj7/6Rr3LEY2yIX0cLiCyJ+xcZrO8RsPkfKFOoh0rzwpSPAIaLGRxcTvKEIjpfivc48QX1qrWEyLTw/Fb4ACHAQTi1VQks5ypyOpeLmCYPwrnIBxqDDOG1tv1xYpoztHjbr5+/3vBLyxxkLkhBcZAZ4YoGTiUQoL/WOQnWI8XjbOuQorPGwSgNQwKxmGCpgZ9svAIlo2evtbodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDMNQ1SQeuQZmUzlN2i8rTVQynE7k5+/nfvgh0fjAm8=;
 b=bGrmGPa0UIQymbxOgx+IPaw9W8dS1fWH8revx/kK1ZQ7MV61+jiLUS8/X8mQ8n/hA03TVXr+gb/iXPWt07hF7uwHZVOXjiDcJx1F5VQnXgYoWpB9Dczw4jDkgZhcRaM3u9slymAJXNmQ0B8CNUSDhVe3pYDD9UuaGFUcRPwdqQrIyVBs2iP358HKPfq/pctX1vuqylp/d0oLuzH5ngYzGfjasoE4iLQtGNXIhunMFI8UoAnc44OxoDaV6hs6jvyWa0Fifyh1ZzMsEt1pnjmAAwKX4sD1cp6lmIEPsHtVAVhaEvhuNYKhU8mb7REK6+cXq+R1VA112xKo5P8YCV5cew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDMNQ1SQeuQZmUzlN2i8rTVQynE7k5+/nfvgh0fjAm8=;
 b=hGXJkUYhZzzBfd6NAAl3hoifRHa9zE7jvF3Gk7txcX17hJHnn5BAB2Wev6UZwkiT18k5KD16XUY5kCoY6YO9vV/CjGakNHZ01a4zCpu4Y+sHxp4GqGFYCM3IMo8EG1BQCwDR8z7s72K9RLhxSGm+fEnvQ/jJHYkBPV4Hl53nrDL23ObzPQKRhpDPYH7YiQvXAKweUD2IZJrA+j5QlStWiAaskfmYG3kGtZVWh5PllxEbHIq2TBEu0DG0Alaq2vLIFlvsBUiePJXo9LDyAhaU4ez7ZXFZn5OCJPcnkiwFLdYBVFZqmbrhyYUXo5N4eooNXbm/idpHjU+kiI+hHLsIxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 09:33:42 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 09:33:42 +0000
Date: Tue, 21 Jul 2026 17:33:37 +0800
From: Richard Cheng <icheng@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Reject delete of a provider-locked region
Message-ID: <al875ItHwiz7ZFeM@MWDK4CY14F>
References: <20260721055131.20935-1-icheng@nvidia.com>
 <20260721060403.188271F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721060403.188271F00A3A@smtp.kernel.org>
X-ClientProxiedBy: TPYP295CA0035.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::7)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a930dc-9124-4b80-1d9f-08dee70b272d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|3023799007|11063799006|5023799004|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	YRafL55a8SS30NtSAAjbJRdJM5DSNaz5AU0QtG9BtquBecbjqikGN3YDYjbQ++8gj7bf4AwNd8kaoTgPPWOxNEO5QwnDZAjiTK13bq5WvsoKdp+hoD5t44NIcG/OpC2Q+r6V7wuYqri+eijELANI/HkNNAlGd36sKXyR+74uW0DWMGOGf80zXc9HXyqGDMqPDgP/qU/VQHsQGjLs+TUFN2V3IHHWXqKcl7jpINHfim8zqtkFyTi6hSyMngVj3MHWKlsPukA2Eyp4SZRF4hfQBobIlT6gizHXrgaITC5KLb7FhV6jGhjq7wKfJ6pIXyCESkAMg5TnbGEFY3ohRsfd1Mgz7H3ELwM8e6fDhL3j3XcciU4jTZaTc5Ch8osz1ur4RkLdXvY3YXeHtphaIYdqZvFmgPm8Hpi6Yl9hHMb+DF45geTrVphMAsMftfSfO6hGZOL1sSFPmee0vD0UnpKi8fBdpMRMqYzRrSnf6IHw1GzQ6YZRdF+p5S4UvWrzlvHPqekc0ty5iytbgjW9tw4/B2fb8nE1dl0YK/KpBQeQgyBOPcfJ2m8FdH6VfSksW18ZObb57EP2bUYmRjYV+LMBTXGJH+L9mpfkB3dIuZ0Vm4UrttKzDXviGkDy80jITiYs6+oKGuwZJiakyxWYkmPf6CwrwoOVpu/lN11srK6CBSs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(3023799007)(11063799006)(5023799004)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?k5JHt65U4JIo/FHkyBwRIi/FGxzIkbEDg/7wawLO/DJ8FH2ZTxkH2mADoz?=
 =?iso-8859-1?Q?SJozsYwNsza3v26A9CIcB6+e5pDUiIybM/QxkmJNsIJibPJvOHvUr858UC?=
 =?iso-8859-1?Q?Pkn9vLGdZHWHFsH0NjUTTNsCJtWfnO4nS3zmtSsOOb+JinHNaCJkH791Mk?=
 =?iso-8859-1?Q?zv8l4YPReUjPQ9Ld7zCwjw9sS85N/fmT6IT8EUjYzze+tgcSZVOD42aVTC?=
 =?iso-8859-1?Q?2QFIeOw9QrDm531o0AKf/mWebwXWbRwWNUclW/F6MdO5KnBJRWu5+e7HBa?=
 =?iso-8859-1?Q?50bygrXnXCZLxNBtmMPIytF7dUXNTrmBmVJkwJKN2jNVdRcNzRVWSgXBql?=
 =?iso-8859-1?Q?Nibf+h3eqbdAQh6u3MfbyBtm0S0cVGUE8kMA/MN2LObQRtXF9VC6GlWNVA?=
 =?iso-8859-1?Q?C3OjzP4L2yErTU8uCTZ1wwnb1cA65k8TQqixsm5a30TzcjMFfvMgsJ/WhA?=
 =?iso-8859-1?Q?0oNfAozwlHkKNJf6kAbQu+FxpimpgnK0cqEiNO/qzPNCgRdpH+zTzn/BIa?=
 =?iso-8859-1?Q?uWa+PhcHDES5g0PXisLUYpLUqUFhW5peqW8z6hM4uC7OGxDCe8/7/ek+mW?=
 =?iso-8859-1?Q?UMyrlaA5fIUVvfcXjdi3ntFqLzUXaRPx/cEvbVkNqMWP82CSPT5Ys6ZZA/?=
 =?iso-8859-1?Q?LbE3TYNV1R5/s1RL6mZFkkbAtCMv0TImwxkDVuBXwrarHWZiBDsWA96eDW?=
 =?iso-8859-1?Q?HJ3ks44XJXLNONPNLMrQWs7HwqoYuz8ZAiQwUsxLbpoOmvb4GXv8cxh8zh?=
 =?iso-8859-1?Q?mnohMYvVyYWABG9SOigbQ1KSZB80OZetxO7tm36M6SbC75X8URABGb+EQD?=
 =?iso-8859-1?Q?63FdjkzLyO+t05AOjmQEbbXFPV5zTO3MiuErUCZHMBE918WzHqUMVE59o4?=
 =?iso-8859-1?Q?/XalPzIQOLZW+5gJdXTkTu1z9iMdcO5B7Wn85R1qlpFid4T3T+nSaDoujl?=
 =?iso-8859-1?Q?QA8VahUXXsY9RyRECOnNRHOvnqaX8P93ePHWNNKdyq8ZknawPfx03Imk80?=
 =?iso-8859-1?Q?FHddCvK0EqYgAsYu/VZLFSqBBJ5cPYWUlZ+E9AYMoSc0pko12/SvjH+uC5?=
 =?iso-8859-1?Q?whysML1iylsyZy3JHKXFHwZFWjnuF5LY+Q7K6xoPl8XaZ4/DkRysOuMUuf?=
 =?iso-8859-1?Q?JN7HJU/ELlKDpuma3fTLt40zgMSHcghgHVE12vYzim26VzowjbVFtqNOPW?=
 =?iso-8859-1?Q?3q9JCn7IIWIftBnHOldLCU/td6SOYyqW6j1s+xFeuApG68ulcDJwtTtr4f?=
 =?iso-8859-1?Q?nUh1gpw6m1z+fkl2diDbO7jVWtg7nhkE7K7w5xbVmgRCAx0yukl5OzLIP6?=
 =?iso-8859-1?Q?/2HhxTn4cwaVJ/WUa4et6ksNqmmZt8rVIFJ3a6IZUKdrD3WLAkC5PUDhDo?=
 =?iso-8859-1?Q?BqQ6pzE+OE5R7nnY9wAy5W0rD2Uhykw42l2hHquILqZP92iwLDXHrPQgb+?=
 =?iso-8859-1?Q?iwOwdVhPa1zQYT0qD/BkRpJv0ru7aKRsMGGLjd0j2UdaqoSvy2vAKFDn2C?=
 =?iso-8859-1?Q?ImyKQp1AHcaDZIaX/atmuQl+dA+v71wtVFGQLldUoddrsjlBSYfpwoo2Mm?=
 =?iso-8859-1?Q?CbZeOIcWM5wn/uRJJYyMqj2Ds+vA210+eiMZ+08DAFu02JtQQcwrhx7RZA?=
 =?iso-8859-1?Q?gTGGAAxE92oUgWErQGzaY6H5ow4uNLyo7SyJossYhPcVHOBbonu3jBOghX?=
 =?iso-8859-1?Q?Q/uTlEBIReuglveD4RElTih4l2EBsF2yCtTIKcL/4VU+KLgL6MnA3iWHIb?=
 =?iso-8859-1?Q?3RO4bU9weiJvdg5fCoC3Iro0OnhVdpLRXu8KSn8gZft2N1kRHpMkHO+RSv?=
 =?iso-8859-1?Q?tKDIPsXtaQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a930dc-9124-4b80-1d9f-08dee70b272d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 09:33:42.3089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xV78IvQwPvkj4+IxliaFp4oAchXGFZDkm1XSbTCfeZrGQQakaVWW9/khjLZ2cQdAjTpHxyL1DG6ssHn2EuRDwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479

On Tue, Jul 21, 2026 at 06:04:02AM +0800, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] A Time-Of-Check to Time-Of-Use (TOCTOU) race condition in `delete_region_store()` allows userspace to bypass the `CXL_REGION_F_LOCK` protection, leading to orphaned hardware decoders.
> 
> Pre-existing issues:
> - [High] Userspace can bypass `CXL_REGION_F_LOCK` restrictions and tear down region software state by manually detaching targets via `targetN` sysfs attributes, leading to orphaned hardware decoders.
> --
> 
> --- Patch [1]: [PATCH] cxl/region: Reject delete of a provider-locked region ---
> commit 447746e2d3844401b6bdd5604c498e319f1e7719
> Author: Richard Cheng <icheng@nvidia.com>
> 
> cxl/region: Reject delete of a provider-locked region
>     
> delete_region_store() destroys a region object without checking
> CXL_REGION_F_LOCK, unlike commit_store() which refuses locked regions
> with -EPERM. This patch gates delete_region_store() on CXL_REGION_F_LOCK.
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 578622240401d..cfc9622c93095 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2894,6 +2894,9 @@ static ssize_t delete_region_store(struct device *dev,
> >  	if (!cxlr || !sysfs_streq(buf, dev_name(&cxlr->dev)))
> >  		return -ENODEV;
> >  
> > +	if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
> > +		return -EPERM;
> > +
> 
> [Severity: High]
> Is there a Time-Of-Check to Time-Of-Use (TOCTOU) race condition here?
> 
> The CXL_REGION_F_LOCK check is performed without holding synchronization
> like the region rwsem, leaving a window open before unregister_region()
> completes.
> 
> If userspace writes to delete_region while concurrently writing to targetN
> to attach a target, delete_region_store() could check the lock flag before
> it is set.
> 
> Then unregister_region() calling device_del() can block in kernfs_drain
> until the concurrent target attachment finishes and sets CXL_REGION_F_LOCK.
> 
> Once resumed, the software region would be destroyed with the lock flag
> set, skipping the hardware reset. Could this sequence recreate the exact
> orphaned hardware decoder state this patch intended to prevent?
>

I'd push back on this.

I think check-then-act observation is fair, but it doesn't affect the patch's
target, which is a provider-locked region that is F_LOCK'd during assembly
before any userspace delete is possible, and F_LOCK is never cleared,
so the flag is always already set when delete_region_store() runs for it.

The window described by the sashiko-bot requires userspace to concurrently
attach an F_LOCK-setting target to the same region.
I don't see a reachable path for that. And it can't be closed with a lock
in delete_region_store() because unregister_region() calls device_del()
before reset.
 
> 
> [Severity: High]
> This is a pre-existing issue, but does a similar bypass exist in
> store_targetN() when userspace manually detaches targets?
> 
> If a root user writes \n to a targetN sysfs attribute of a locked region,
> store_targetN() calls detach_target() which eventually reaches
> __cxl_decoder_detach(). This software teardown path lacks an F_LOCK check.
> 
> Because cxl_region_decode_reset() deliberately skips the hardware reset
> for F_LOCK regions, the software state is dropped while the hardware
> decoders remain committed.
> 
> The user could then write 0 to the size attribute, freeing the physical
> memory while it is still actively decoded by hardware.
> 
> Should store_targetN() or __cxl_decoder_detach() also be gated by
> CXL_REGION_F_LOCK to prevent userspace from tearing down the software
> state of locked regions?
> 
> >  	unregister_region(cxlr);
> >  
> >  	return len;
> 

Will send another patch fix for this one.

Best regards,
Richard Cheng.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260721055131.20935-1-icheng@nvidia.com?part=1
