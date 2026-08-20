Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C461D3FDBEA;
	Thu, 20 Aug 2026 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787218935; cv=fail; b=CzyEnjeeMj2eQlG/Eua7mWjY0DJKNW9ENtO6ZeVwjOB3fucn0Zw5ASHJZUo3LviFU1Y9ppdmsgOrZu4xTDV4raZrwH0WReiqzbbuD9CAICLoXJGP+Jew7f6W/wWbjFEnkfVqYDmvnjrCUDh9fAjOSMeA4KdDhxyRTAhqYAEcWJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787218935; c=relaxed/simple;
	bh=FGVb5Y5YlCVHn/1tx3m7xC5VRXFXzDSUfwzyeGMRPLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CPEzdkwDGeX/sfBeWQM8dZdgl5gxHz/T2bcQYPj4wGkvPbOwee5IwfYjGHYCCmfG3L0rWDmIExjNqRBFIrUFk9krM4dJlJrI//06JkNh8lV5Dxyqpn5gieX5ibshM9X+PyEIE0psSBjc+jJCD6avXnJ6Rccg74oLZ4LkwGh+XOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WcaJINJ9; arc=fail smtp.client-ip=40.93.196.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WcaJINJ9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXs2fGsKHsodrI8ZMF1PxK12ER7L7n0M/5UgT1137UdxuTwwnkz0dFNsz0Z95Qeo+JzIMyF8DVa8OhkLdYMSMZtu1mdUwI114H/uF4u9Jd98YUQ4Y/5DGt7ulz6lNg3gbUimuKIstutXNSeQizgpiag6xGZqGec8e+LZVh26+XbCuspiLYAIaAx/CjIA0EAKzOCjl4jRa07XIMUtmgEwlH/LBEhwOaO04F6Za28LsNSnsxXy704K3c1k/R8QQ9wz5wgGlVjpDOTPcI62xF+FaTltjFwvvBUhBhv/VxOb9iiZ98Ukdb0j9Tc2ku9rOdax+SVdFPwDwUrrHFQ43KlHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUO8bKHzUa70G5GdmFhxfzayFAwHRDeQOaEcAnFSNB8=;
 b=dNZEDPEbGu2EPloKUCVl2u/EbN5QDmOx+iuR6CWhDlDB61nfXrXxWW56n5vBmT9LiNDgdax5Eod2Us8SpIXygE7MSStWZbp4T36yiZ0iUo9UO8Eoa3KI85QlPKamPky8Fe5IMHfniypddioLz5ULIdFOTRbO82RHb8iZbcb7vAqmuIHOjfJHJ/FdPSoZZ9V/rfgGaTGFNfhZqvVmVHsqMAzQ0CMTr2+EWQ7U8sNH3UOKdvtLXeeOkTcuHglN2XU71L3Czg5IkliqWa1su0xUP+3Cgo8mmpgaSDoaXCFBWvv0DgVXHqBS9PSyMyLNnH3+muZhMh02bNZdqOoGXcCBHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUO8bKHzUa70G5GdmFhxfzayFAwHRDeQOaEcAnFSNB8=;
 b=WcaJINJ90MEjSUxhJnBSO3aCcVf0c9cUx9TI7Hr0hWBDx5ceqR1tfBbJPYaaWgBTsyAOX1EDQ2mfs0JcaDfAhCH2arb5m9h1puNBuSgjOY3IvoHgE0RVskaIwqwlSNg2V+h/4WKso9kOGtM8zuetK4NVVbcgz4QM09gksW+TWDFuZ9+HyKyAYrQ4147NNwuqnzPOLw4RX8ThuGT2PDEHsLilMqS3z/hK3dr0Fz/6L6ZQtmLNqakZmnAnp6XGXjiQYoL4WvLQxctKa5KTgqMnmr4JBF9yFjH92GBkE0CMdHLfpTHBO1vJgOrGjr8X6WK0zvXZnfKq2MphtDdYuuquew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 09:42:02 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 09:42:02 +0000
Date: Thu, 20 Aug 2026 17:41:55 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alejandro Lucero Palau <alejandro.lucero-palau@amd.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org, iweiny@kernel.org, 
	ming.li@zohomail.com, gourry@gourry.net, rrichter@amd.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com, 
	kobak@nvidia.com
Subject: Re: [RFC PATCH 0/3] cxl: Auto-create a region for Type-2 memdev
 attach
Message-ID: <aobIoBYBACGlJ-OD@MWDK4CY14F>
References: <20260805074042.30173-1-icheng@nvidia.com>
 <a3978557-59d5-49bc-bdb3-9ef2dfa025d3@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3978557-59d5-49bc-bdb3-9ef2dfa025d3@amd.com>
X-ClientProxiedBy: KU0P306CA0094.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:22::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 51543ff4-9e3b-48a3-5d3d-08defe9f498d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|10067099003|5023799004|4143699003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	kGfD+KWfojVMoJ0mPhk5yJv3eJsLWVlJz9iB0KjapHlRMA2mDoOQnDAOnN8pGG4nMoMTBQuUl18dMPjgOPUXVjCLOFlsRurneWkhXLjsxaHhhumIUatTE/Eb9X9wus6jc+aRPNymQHEed4gMbep4HYxN4CZKLbJ4hxLTzv4U9t0GqxC99RpUBiW8FWtoBgCL9ttqjYCh6miEPknfg5Z04eWjmJoHRKYIH4Efwtc5HjP+G7OUne/rvP6YXkdURIDbYEmut/qG2U1/FYXVE04/rC/ab4IC7+TRBt4I+txLZnaZ1aTmwpMJSjDhuVKpbLwh9TZuGgpalI9erFpHuWCHPJn6p8XClagZLF11WTjQy4bjYqC1Iv0C38/y7tsMuXsGYh71nDPtyJg+TZ3vSYoxCAjnHY+s7wIa0+goJ3ZRQshyO8fov7UBEmGhvTPawuGvsWY2hfJr1ljfxcB47CN8t5lI9b8mSNxgOUHb7Qa9s2IT+gK0noL1Vf526Ky+U5kn2I/Byt/CjcAJSbZDujFjXyarQHIFDaKfgO8t9QA6lc4+HrvtIN81VS+dcDlhfM/Bstxj2cqDBf7zR9akmWeNUBKQZND6rmsF4XjhTSM3MAzd+K4s86BRZuSyTWFUbX1mPERnt514iYfFtqnDuyYIZDWVbSm/TK/YSC0UzNUP09s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(10067099003)(5023799004)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jxnzx9qAoNmS4yVDZsu8twooJPrrFB/0iQhpTYIbpIApibxZa1g5BItbSILA?=
 =?us-ascii?Q?yFjm52flK5956pxC4l8ZP2Og/+DyURQXdzRWAhaRDjaltZ4SpBEQBnajFnfJ?=
 =?us-ascii?Q?soXcAKNXE29kdZl6ZU8nm8VOrNIsh5HZFa0bL1gr1B/kdpWZU3/dgymtRqG5?=
 =?us-ascii?Q?YWwur1XBQMhb4bCdAwSi7MFCQ/p8utDdEzgXPbsERXd72YT5tfg8ZW9ovgTq?=
 =?us-ascii?Q?5uKOwgNrbCWxmMR+rGZfMIWOebW8CfpYF7Asp8vqzekysN2LCodD/sQLNiwG?=
 =?us-ascii?Q?zHU/Z00L6Wf+YicWQU+In0obwQ3LICW2qbDSlNM1Fw1DAc5DhdfBOJjpOWk/?=
 =?us-ascii?Q?a0sytay1nMSdTRNfB5glcYA5Dx/BNRqP1DVeH07pzC9UE5wRdpKVXaN3gBAW?=
 =?us-ascii?Q?4TI8ffd9kzTMtcG2daiaDOy3Yvr/RAKKEjq+72TmvWu6T66370qcrDcZuiGP?=
 =?us-ascii?Q?cKhTHnbPNBbl+/9m0ERuw4vM63vFjVLO7bwiIvTtvWiIihyzNTKFe3M5DcJb?=
 =?us-ascii?Q?XCf03GmjZ5UQpKnnnX1rfIouWn3fDAlsXmkb1wkQF0NsdM1LVLtCDzTgA628?=
 =?us-ascii?Q?IdkAL4wyj5TsGvnazCa21lD0kfI+ymWpUJm84IzRrLh4vfsZrp6ttTPZsogP?=
 =?us-ascii?Q?YiKovIPzYSeyfxsc8g3p4PTB7HmrPbDJt6ott9mWd1HueF7Pr3whfu/qVLTK?=
 =?us-ascii?Q?G4bZXKcvshAh8Lc4xnNBGdoGlw8LmTEWMPnfIVItVkzz6gnKQ4YNzn1ZY88q?=
 =?us-ascii?Q?5Ljr+g1pIo+idjeh3FsHqQuZ+ZJY6U6v8o3MfeN+S7he1VY/Z0Yq7mbJ9nrz?=
 =?us-ascii?Q?MeWYT1+nDZJFzOVB0mxa0texxTOF4v+LmVyyZbykjXglC9t9CJn0m6bYT6Ae?=
 =?us-ascii?Q?gHg5vHjEcNpcFSWXYLiwT024FbF6hN3bHgMHVE8VyyT7BLslaNbPCjfvpxuB?=
 =?us-ascii?Q?ZBh3pWrAWPT93obtGSoQTasvtocSkTa77XkcQlfvPs40fFXj4ZmUTIg/nXdH?=
 =?us-ascii?Q?4SpNpqZS8/CQdkaeTNh3yBv6BYEmQ4faZQorhzmP4doNr0hkCoFhEBUV3ybs?=
 =?us-ascii?Q?aISlIK5kzVxTq5N9pK6e4PdrDkhZ+YvwEznNRAn7k/Bf/MO0u3KK4aBbx674?=
 =?us-ascii?Q?Iny5A1NwpZEtiiaKPm/OuRbKhQRV4Y38DHPJsXsFVRv3JCHVoxhfNVrkM9bH?=
 =?us-ascii?Q?xUZtxaDruVT96RW6tbo/ry4vO+TaDKU8TZzivNC+XHALjTSeQMQfzI7BMBiE?=
 =?us-ascii?Q?micAgffaQZm9DAhUf/0qdq5q+Ecj376O713gpjEQnN7qsDt9xDvtoAOPMdbk?=
 =?us-ascii?Q?OodFXw5COQKcTAon9gt3cg51Z16UUtbbHoCuOdfMx9IbDPYgkiPUP07iJOMW?=
 =?us-ascii?Q?gj9bZmm77GiLd3sHvzPEN0MOQiFtZgf5eFCW5b6jzRk9FReSyG7CYTKhFsEw?=
 =?us-ascii?Q?RHl5W+JDMq3opiN57C72WpoNeYCHH7bctl9VHbgfwfQ3pbiLLxTAPafQOAap?=
 =?us-ascii?Q?b8kwrK49d9UK4MfQNG1k7Nr/NHF8Kv4txTdgz2SBFHjSRA6WRdfYkdSyLnfQ?=
 =?us-ascii?Q?3nCAhUw/9TAiCHyTr4bEhsbMba6u/N3CnYUmS9WhjwMOCcUjzD8aeTlhxAQO?=
 =?us-ascii?Q?mzA94BAgK22br4pco0lPD5wjmTFntuvtPzZpGcO8Cq00Aa7H/ucxNWw/m6/K?=
 =?us-ascii?Q?8ub9nPJe06c3ymYMPaQe2rbOkFhBjQ30NbNifnCpvtFgB4Z1nvC6YQmiUxyd?=
 =?us-ascii?Q?ODhcGCEDxw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51543ff4-9e3b-48a3-5d3d-08defe9f498d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 09:42:02.4457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irxkHlHkZbTjG/nqZDbbTF0Zro9wEawX8Swl+Zq0FxyLitLoT7Mym5PTgJu0uQ6WXnN4QW0s6jvLXRQK3adWiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166

On Wed, Aug 12, 2026 at 10:58:02AM +0800, Alejandro Lucero Palau wrote:
> Hi Richard,
> 
> 
> Some comments below.
> 
> 
> Thanks!
> 
> 
> On 8/5/26 08:40, Richard Cheng wrote:
> > A Type-2 accelerator driver calls devm_cxl_probe_mem() to register its
> > memdev and get an HPA range, but today only if FW already committed a
> > region. Real accelerators can have usable memory with no committed decoder,
> > so get nothing.
> 
> 
> The previous paragraph describes the current situation and the next one is
> about what the patchset tries to address. Maybe to explicitly make the
> difference would help people not so used to the subject.
> 
> 
> > If no FW region is mapped, the core picks the device's unused manual
> > DEVMEM decoder and a compatible x1 Type-2 RAM root
> 
> 
> I had to look for this x1 reference ... and I would say it creates
> confusion. At least it does to me. Not sure if you meant interleaving,
> because I do not think you are referring to link lanes here ...
> 
> 
> > , allocates the full
> > volatile DPA and HPA, commits the decoder, and returns the range.
> 
> 
> This is something requiring discussion or clarification. I think it would
> make sense the provider/driver specifying a DPA size instead of using the
> default full size. I think there is a good reason for this non-default size
> use: why would the kernel create a region from a CXL Type2 device using the
> full DPA size when the FW/BIOS did not do so?
> 
> 
> This leads us to wondering why the FW/BIOS would not do so, the use case.
> Current Intel/AMD BIOS (I think you have the aim at ARM servers) are not
> allowing this case ... for a Type2 device having all the bits in place. If
> something requires to be specifically configured, would not the driver do so
> before using the CXL mem? If this logic makes sense, the auto-creation
> should not be the way to go.
> 
> 
> The first 15 Type2 basic support patchset versions supported the case of a
> driver specifying the size for the cxl region to be created. And it was
> through a specific API call after the memdev was created. Last Type2
> patchset and the functionality finally merged only supported the case of
> auto-create regions from committed decoders, and using this final agreement
> for region attachment by the Type2 memdev/driver. I think it makes sense in
> that supported case to have the auto-create region but I can not see the
> reason for the case you are addressing now.
> 
> 
> >   Unbind
> > resets and removes it. Strict first cut with single decoder, IW=1, minimum
> > granularity, first-compatible root.
> 
> 
> I'm lost here.
> 
> 
> > 
> > The design intent is that the provider F_LOCKs its region against userspace
> > but must reset its own software region on detach. A plain flag would also
> > allow reset on generic kill/delete paths, so we thread a reset context
> > through teardown and commit rollback. devm_cxl_probe_mem() may now commit
> > decoders.
> 
> 
> If there is a real use case for this auto-create region from non-committed
> decoders, I think your patchset makes sense. But I'm afraid we need to
> discuss this further.
> 
> 
> Thank you,
> 
> Alejandro.
> 
>

Hi Alejandro,

Thanks for the review and explanation. I've read them all.

I think you are right that this RFC doesn't currently have a production platform
where the system FW publishes a Type-2 CFMWS but leaves the EP decoder
uncommitted.

However, the config appears to be permitted by the CXL model. A CFMWS describes
a FW-established root HPA window and the restrictions governing its use,
including Type-2 v.s. Type-3 and volatile v.s. PMEM. The CFMWS def also
describes OSPM assigning HPA ranges from those windows to discovered CXL.mem
devices [1].

The Linux CXL doc similarly states that only root decoders are required to be
programmed during probe. Switch and EP decoder may remain available for runtime
programming when the platform supports it [2].

I raise the RFC intended for the question of how Linux should support that
architecturally permitted config.

The cxl_test config added in patch 3/3 constructs this scenario synthetically.
This demonstrates the proposed kernel behavior, but I agree I don't know
whether there exists a deployed FW scenario.


And I agree that devm_cxl_probe_mem() shouldn't silently change from
"attach to a FW-established region" into "allocate resources and program a new
region". Those operations should have different semantics and ownership
expectations.

I am planning to rebase onto cxl/nexxt and rework the proposal as the following,
please take a look and see if that matches your imagination or not.
* Keep devm_cxl_probe_mem() behavior unchanged for FW-committed regions
* Make region creation an explicit request from the accelerator provider,
  rather than an automatic fallback during memdev attach
* Have the provider specify the required size. CXL core shouldn't assume
  that it maybe consume the entire volatile DPA partition as you mentioned.
* Separate the reusable region-provisioning mechanism from the initial Type-2
  policy.
* The common mechanism should handle HPA/DPA allocation, decoder-path
  construction, commit , rollback and managed teardown.
* The initial type-2 caller would constrain that to volatile DEVMEM, IW=1
  and a provider-requested size.

Oh and I'll replace "x1" with "IW=1" and explain the initial decoder,
root-selection and granularity restriction more clearly.

How does that sound to you ?

[1]: https://computeexpresslink.org/wp-content/uploads/2024/02/CEDT_ECN_1.0A_Eval.pdf
[2]: https://docs.kernel.org/driver-api/cxl/linux/cxl-driver.html#runtime-programming

Best regards,
Richard Cheng.
 
> > Testing result is in the following.
> > - Built clean with clang/LLVM on arm64
> > - cxl_test, type2_test=1. accel0 takes the unchanged attach path. accel1
> >    drives auto_create -> a committed 512 MB RAM region. The test asserts
> >    the 512 MB HPA range. committed state and 256 byte granularity confirmed
> >    via sysfs.
> > - Unbind tears the region down with no orphaned decoder, rebind re-creates
> >    a fresh committed region.
> > - Mock test only. Real accelerators whose FW commits a decoder take the
> >    attach path, and vfio-cxl binds only FW-committed devices, so auto-create
> >    has no real-HW caller yet.
> > 
> > Best regards,
> > Richard Cheng.
> > 
> > Richard Cheng (3):
> >    cxl/region: Reset software-created regions on memdev detach
> >    cxl/region: Auto-create a region for memdev attach
> >    cxl/test: Exercise Type-2 automatic region creation
> > 
> >   drivers/cxl/core/region.c      | 422 +++++++++++++++++++++++++++++----
> >   tools/testing/cxl/test/accel.c |   7 +
> >   tools/testing/cxl/test/cxl.c   |  61 ++++-
> >   3 files changed, 439 insertions(+), 51 deletions(-)
> > 
> > 
> > base-commit: 1c6b4ceafc3b994871c29340e0c1ddb0af5800e7
