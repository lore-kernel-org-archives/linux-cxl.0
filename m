Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA48D188CC9;
	Fri, 24 Jul 2026 06:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784875107; cv=fail; b=SOCnUT80x/JFfNYIG7gm06yWNM1zMJtaqY50Ib+pjkzt4gfzEBrIrI2XTaQew1Yf81DSatBEMfEbRsc5WxxtHZncMd1QF/gUAyzRfiQVr65a1PA7beGtu4ASlHGYOrVliv19dgoJLfL9fPYya7emMBIVjTeUDzmM20Xa2V8/4As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784875107; c=relaxed/simple;
	bh=4HH4w702XeHCmrlP3ip1KGFaBZGEa3FMfDfe3/mz7LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HWsWkQFAJLVMShVQNTlLX5fQ3jPqzs2Yt/TIRokz2CyrjJiQEmqQmdKWiiAlQD5ul8s8J298bRdJhFzDrpfZ3qPvD7rzzbCQMrdWfpsKaMjy0nYkbbf5uAmMjuO12pMz0hAGhPkxhD7Lxh0Hvcs/AZlOPyukUfwct+ph0wyRQYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Myal0x/q reason="signature verification failed"; arc=fail smtp.client-ip=52.101.61.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Myal0x/q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zS71IdaZKnivhKWshaPkGrTPjx/UMduooqiHGux0Amaa9w+XEthpInRkD1MDQIAemJBb+WYuRHzRFFJZLBLVjzkzwmSexjEHHw9HeRzEsgnU1tgsUL+qNybfFWnLH+IH1LGgtySEsjmVkhObHsZuABqUxNfU70R1xIKCTobedCjBxI4EP68uP8TlRVQ8ruAjV2urSnoJIShwd+knT5QQ0RSyVvHBA1aaEZ5EiLdWj+jTZ9fziiqZsudNKl+owmdrmg/O20JPuwuOAAuZ5+Usge2YL+SX3tILyAii4i6h/ayul3dSoXAVrQ0kh1N9r11yuk05+rn8/enLgLrycBtifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Xr4QNAcus2pDYBaah24EfQE1QCS+KULrb3tyMpsJFU=;
 b=KiuRE9bqjoBfdU/EQRpCEyeqJI+rCb2DwEhmkKWrxAGbcoGhQZBdFuRLIW5YwDZyOt5njACEQs8ft5+VNbfzKbXv+kRH9FyhHle4sukS6xG01EN3aAVtOpqCW3QbZPO65khcVnlxL+DRCGKaa75+CuONCqn/aS68X9gYvhsFp0mPauQs3KjfUjq134Z7qLwT6y/FU532sXkLcRV1rIWAQz8rVEWPTzV+PYtgmg9gUNGdWVjPMlg6fRnJ9/8S6rSlMXU7UIMuiqpvJuYtboD88I88mOQRzTYm1WiluXKQqgRryY7Rk9neVB5GgtCSuwld6Ps1Uzu8G/9orFj4A6/c+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Xr4QNAcus2pDYBaah24EfQE1QCS+KULrb3tyMpsJFU=;
 b=Myal0x/qMBlZgSHxK6Wet+1yhir04laG6bBg6dRVStHuCLwa0DyHDjEE6SqY+AU2NAfYkZa3MIyddwadWz++HHxayibJDMrreqpQ4xiZOKDArujJJBRu/oleueXSLf21WkrncwRZHuuACZWSRLtyu1tzqjQ4xLi/oBbFAdYmtq86/eDycZWTYl2o63LyP2j0di3VE4+e0yHhMHsyUXHQ0f4McsH4ejGJVRLRsmKi/pOpKVDg8vtlG66q9lYRO0jPseSV5BHZiI+jAMb5G9MY3kESBJ/RuV05+Zy5qSCQvvzmx2DhU3ZeioGt1x2J9gfdPy/hpKIIBvfnbfanYOq1PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 06:38:22 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 06:38:22 +0000
Date: Fri, 24 Jul 2026 14:38:15 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, djbw@kernel.org, danwilliams@nvidia.com, iweiny@kernel.org, 
	ming.li@zohomail.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
Subject: Re: [PATCH v7 0/2 RESEND] Support zero-sized HDM decoders
Message-ID: <amMIAjOCTDlSpH_S@MWDK4CY14F>
References: <20260721085715.39322-1-icheng@nvidia.com>
 <20260722010731.053a6bef@jic23-huawei>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722010731.053a6bef@jic23-huawei>
X-ClientProxiedBy: SI3PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::14) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: cf868f12-216f-44b9-f71c-08dee94e2796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|7416014|1800799024|6133799003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	5gGlusvfs9hD1nwJuMH9SPYtBn5GCCBuU7cQ3+QswW0VtIXQdiLjuyRin1+jboRKG2jZYdwXGiwDv5NGT30mppf8lfOYpIpaQqCm4KGv84Kk9ebvUbTq+pCaxJs0kA4okv/b9qrvBVuKbfK4BD+H0YV/vS4WrzdQ3xg6YLolymWWV/MMC93r+QtlufEWj9DQXN7U+vDbkT0p/BlxrpzmX2z6emn0puBlsoEuRxm/UtOwp+d+zun/OnyMnOgq6H6JkqrB3/p5oJErBsubwuBXmDZpZIbZBcq01rWb1oWrxXbbxBvKq+WUqpwapg/EwV8MTBMfCj+/wARvTLUYWt1gPogsiaoeFmnUmu4a18yv3035h2j/HMM7iJ0Z3BNiazIOg4P9D9/rvwZfgQdX2D1YN1BXfuQl1C9idT68YJebEVphsF980fVBgZr2VkDgavu1mGyUJmZ7D0xFcRAqGOxyCHbqWmrNo9J5ZOXkxDKHTV30DHRZ0zyzhcq1eQvidIvQHBk6Z9AGCGhHTS1wfFqleINkddpfKbYSziTreamW52tfW5IP+ldgk+BX0gF1rc1askW1lGmXlf2ZEq3s1DBg8fYKyzH53SdKP7zMKds9edUJAIsSZXSZO4JHVasD8mG6pA4Gmut5lQOLYXBNvOSMXemLcdj99z/IZ8Ax59mn+ws=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(7416014)(1800799024)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?26WrnzBoCaFf6bqVcvdFOBM5Dsy4WSpbXhAdAFfnaRqmXRn3Z9hm0QCSMu?=
 =?iso-8859-1?Q?UZlSH5DkFSPlM/QeimGnj0DxSfh5AIrHxavp1ANoPIKhIf/lqF9UzMHIKZ?=
 =?iso-8859-1?Q?uWcn0TlWnlkODPCYImS5tsH2lYSOWES2gN/BVYWIOExH7HEOMerMiMk9Bh?=
 =?iso-8859-1?Q?+s+GxBILZ8tcsYX5e57JBlMowx+FgyIUnTc6cDep2csNM14dcOW6taTLSy?=
 =?iso-8859-1?Q?RyYEkD5vTvR3aP5Dy6Co02+bHHOyXnJO91tBU1qrLSzUxj5Mvq66AbM3tL?=
 =?iso-8859-1?Q?Oy39AdagotvhIH0FqffINIr2lQPv8ORmyc7N+pO8VLFzOWwQTvBnUo8gN2?=
 =?iso-8859-1?Q?LS+M9ae2TRs0wq90sjLUDwqXv/g3y+JZxv/Od9frNtVajIOJCysCNCrfIs?=
 =?iso-8859-1?Q?BjYCtMsa7PcNQdmNN/RE+hJ+6oRo4Z59Q5hmLTOWAm+rPql9O1tA1TRiYd?=
 =?iso-8859-1?Q?bnSWNOR+SoO9LXR2X2IE9cl6pSS8W5Yv2A1eSAzcJ1R7cXetcmxv3nsW85?=
 =?iso-8859-1?Q?5TRcZkrghPs5peWsU+Xxk1YbyyGFo5EtmyQc7lqkms8ecxLUf1X/s6G0Ud?=
 =?iso-8859-1?Q?TLBB9rFxp/LUU+IoehHyFGTM8fuHbE4X/gHCTFjyJXdicuXL5CmP6NXTKl?=
 =?iso-8859-1?Q?2JGlyQJfLMyc2Bsh6hm3pLqWMyp1mAcIyRjJFoPOvgKec+1viiN6nn2tJ7?=
 =?iso-8859-1?Q?hgzSHd18+sKztc7tbmQX0X73bRGASRVIF68vz5xbu04gO9FmBOpYTR7E+V?=
 =?iso-8859-1?Q?P21+Ny4VS12BrO4FPAVIUtbw9DZ+Kkp9snL45FjtMhPgM07KfFICKwUDWJ?=
 =?iso-8859-1?Q?wZZwJxEEcbSyGrmtTYn3geRkT7dbI5EL0urXjRDQs9SlGM1N7VeBlP9FoB?=
 =?iso-8859-1?Q?XEMb1dA5bGyzpkOeKE3mub9IQJu/uJ1J7d5g7PXRAMYYJH0+q01ub7rYoq?=
 =?iso-8859-1?Q?fSHwaZlw1ar3U+l3QfnqX5BMD+dimXLeqmfm2p3NX0JOpYb+eUfOgb3afK?=
 =?iso-8859-1?Q?Yn2IYpZFE3z4AMPxy4b5r3LMRgTtQpnPnsfhK0a3eBHgI9y2YKBm674rKA?=
 =?iso-8859-1?Q?W3rDOqGHplBvLWG25hJNb3uz0QDScX+76Dn8lpSjDusofSddZDquOL+4tW?=
 =?iso-8859-1?Q?0/QoW1b45k8Qg43Xbh2RYoJAcCjQDgjKDE2zeYty989jd2QEHXpNXC80AI?=
 =?iso-8859-1?Q?eabI6Vtavam4c7hvcbREYibiOsw0AO0JxMG9qUofXqPNH312m+UbW3kmK2?=
 =?iso-8859-1?Q?cr7C0nSW2kZ0aMt9FJDPwQQfRVtOCjXEh93qOvykbWjtlrNRfsFZ3oBAat?=
 =?iso-8859-1?Q?fBgl5Kt8rwDuD8vzJ7BJVj1NVH3PAPIRQSq7BmKvHrWhPE5Q3Bj43m3Vln?=
 =?iso-8859-1?Q?AUSKoqDBCrynkR86vrq0NV5SSLGRDBl24nUlOXIay0tqzZyrtqD9C+0InR?=
 =?iso-8859-1?Q?2++k0x8m8dEQuox1MG4awoPprTeUOfeyrfpT7t4w5wkznAYLtscRB+PfjK?=
 =?iso-8859-1?Q?zey2u3jcWIKzhfDlHi+piRZ4cB+jWNFKkABuelKTSYrDUZC8SpLl1SoWJT?=
 =?iso-8859-1?Q?L5VbNiMLVgK7PNIroetf0mSGnagRw+xpc8+AONBNx9Bu6vnAzEAcqJN1qE?=
 =?iso-8859-1?Q?3Nf6QVdB4REdvtoT6z4UEXO7s/Zq4Buo4dHyUZxDAVc8LbgjmwH1uK6mu0?=
 =?iso-8859-1?Q?VOK30HV2BuSEh76OrfdOa0wS9mcKW2h90udcqzktEOVTgL+hOb2m3k/Nuj?=
 =?iso-8859-1?Q?atnZK0MwuKZpQu9aDZL0AsdHw9IUWjs94M4gosG+4Vl+Qu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf868f12-216f-44b9-f71c-08dee94e2796
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 06:38:22.0275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6rIvCHjVSOwYtXn+ItvUyuoJV3FQwy3iWQJDm5brqJIERid0bJAWoKqV8qqjPQn1mz9swaq+UnZChduK1uw9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676

On Wed, Jul 22, 2026 at 01:07:31AM +0800, Jonathan Cameron wrote:
> On Tue, 21 Jul 2026 16:57:13 +0800
> Richard Cheng <icheng@nvidia.com> wrote:
> 
> Hi Richard,
> 
> RESEND series should always include a brief note at the top of the cover letter
> saying why. Otherwise it can get rather confusing for anyone seeing both.
> I'd also always reply to original post (even it when to subset of people
> or similar) just to call out you are resending and hopefully stop
> the reviews getting split across the two postings.
> 
> If it was just that it had been a few weeks, don't resend for that.
> 
> Jonathan
>

Hi Jonathan,

Copied that, I'll keep this in mind.
Sorry for the inconvevient.

Best regards,
Richard Cheng.
 
> 
> > CXL r4.0 §8.2.4.20.12 ("Committing Decoder Programming") and
> > §14.13.10 ("CXL HDM Decoder Zero Size Commit") permit committing an
> > HDM decoder with size 0. Firmware may commit and lock such decoders so
> > the OS cannot program regions through them; this is a platform design
> > choice rather than a specification requirement.
> > 
> > The kernel currently rejects these decoders with -ENXIO during port
> > enumeration and aborts enumeration of the entire port. On affected
> > systems, this prevents the CXL topology from appearing in userspace.
> > 
> > This series enumerates empty committed decoders into the topology while
> > keeping them out of region assembly.
> > 
> > Patch 1 makes zero-size DPA reservations first-class. Since the resource
> > tree cannot represent an empty range, an empty decoder is backed by a
> > separately allocated resource. This keeps port->hdm_end, skip handling,
> > and in-order DPA accounting consistent. Operations requiring non-empty
> > capacity, including region attachment and poison queries, are guarded
> > appropriately.
> > 
> > Patch 2 adds the mock_zero_size_decoders cxl_test module parameter,
> > disabled by default. When enabled, it installs committed, locked,
> > zero-sized endpoint, switch, and host-bridge decoders under
> > host-bridge0.
> > 
> > Testing on arm64 covered enumeration of eight locked zero-sized
> > decoders, DPA reservation and release after those decoders, ACPI
> > unbind/rebind, module reload, poison handling, and rejection of
> > incompatible cxl_test module-parameter combinations. The core patch was
> > also previously validated on a Montage CXL Type 3 device.
> > 
> > The corresponding ndctl test is attached at
> > https://lore.kernel.org/linux-cxl/20260709022857.18732-1-icheng@nvidia.com/
> > 
> > Changelog:
> > 
> > v6->v7:
> > - Rebase onto cxl/for-7.3/cxl-type2-test.
> > - Patch 1 is unchanged.
> > - Adapt patch 2 to the refactored Type-2/Type-3 decoder initialization
> >   paths.
> > - Integrate mock_zero_size_decoders with special-topology parameter
> >   validation and reject its incompatible use with fail_autoassemble.
> > 
> > Richard Cheng (2):
> >   cxl/hdm: Allow zero sized HDM decoders
> >   tools/testing/cxl: Enable zero sized decoders under hb0
> > 
> >  drivers/cxl/core/hdm.c       |  52 +++++++++++------
> >  drivers/cxl/core/mbox.c      |   3 +
> >  drivers/cxl/core/region.c    |  49 ++++++++++------
> >  drivers/cxl/cxl.h            |  10 ++++
> >  drivers/cxl/port.c           |   3 +
> >  tools/testing/cxl/test/cxl.c | 109 ++++++++++++++++++++++++++++++-----
> >  6 files changed, 177 insertions(+), 49 deletions(-)
> > 
> > 
> > base-commit: 1c6b4ceafc3b994871c29340e0c1ddb0af5800e7
> 
