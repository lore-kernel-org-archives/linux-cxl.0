Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CDF209F25;
	Thu,  6 Mar 2025 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253908; cv=fail; b=EBC2By4DuN+DJbH0/K0S6/Lp87xU2GWuazZ5bXQyjoExXbwl2WbQHKruOmW70gmL/TlcDH6TNBea1zM12nWwglPFXjpmAphmBTm3bNw9dlHJYlOyIgHOAJGILqDZlEjU2nbSSOBNBd+NS5vkmcsmSWN88220sAq62RWlM6/5Wzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253908; c=relaxed/simple;
	bh=5GLFz6r0BMJQ40zynLy2T5/hDLrfZu5CLanZp9CcLQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lXKjb+Y3Z7pZm7wsqdn3msI3PxX8QJ2Sx1o4zTe4upO/8EpSv8Yl/EELXhgZYKcH1w/+9Ftirvlpny15g3t9h+gz0b9xm/oVSkxKWjpOsvK9Q0wzQCWUaqMk8kq/rMDqswVdz57SxKF6aqfj9HUkI19flHOOYD+TOmDnRkCPPDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nZZv2T/F; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nZZv2T/F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zs1DdDF8m+rmq799yFeBTEq5RDkeRFf/Lu52Ctv2GHKsHPRb8XDA7R3t20nLsAelyNN3q6l6U5MQDrqNSUFCsLbfV2U5o4A7ecG6bYI+9mMKATOPX+CMA/qQZIA7YgNNYEJT4B+/yrpPJ3y07LWR8mOgXxqiGwmdSo+zp458c1BKmK9ommVL+hJtxJO/OCtDUWJoS9dxN/PomK7BXoD+iYfVHEHjXwH4fPkpfx3ZkHGkupprFKg8TdgOAf+vFQjRvHxR6y7aH+01eeNSr7guD6VyaEpyXtbgChe4WbiUpLmpkH2KKbkxe+V9dyZckcCQIP/4c5RE40JUGuBA7MxD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylY3LqSCk2dnvdxZqHhtPBMveN4DlPbuuxRVQbodGCs=;
 b=f4OnY0GQ4MUKnw28T/NsrPU7+TdFVPFxyhD1AS0oUnv5uSzgJzMpEAOSp+pibh7pOhdD6OxG6VYkQNULqlUcFMQ1EXc0JoJv5rDa+hwzzfy9ob5TQD623DDdLH7TxyeqZOT+zE2HvhanPXKKHZlIqOZAmbtGwI1z14PkL7rN4vryqr4MHnwo9UUK4pcDeNwaIJX4JRYTn84yWlSl2oErFdm3FzL/JFfN/qw7VIovncpG1Pf4HUqAXJKkGhlsivxoxkL5S5uqEuf83ToUqaEEIdxWjZZN+yMfQ9M+tuq+/NqCO8mX3ef3hFOOQZdXqPAUW+tEjJ37tbkM8zl02JE53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylY3LqSCk2dnvdxZqHhtPBMveN4DlPbuuxRVQbodGCs=;
 b=nZZv2T/FC7W72Y7i3Jl3m4DI36sOmcwLZKtqPgxxfDBOMnwgcQ/DcCglke2ka90FV/8LVsH33lVwmcuJpoC3Y3JWeCnuF1vc8nRTPXSuizWbIv5EKW2AYQMvx9qFGhLtIKJ4JddClH4VStub49XES0xkHnAVfpqCDiRheycIdMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SJ2PR12MB8977.namprd12.prod.outlook.com (2603:10b6:a03:539::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 09:38:24 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 09:38:24 +0000
Date: Thu, 6 Mar 2025 10:38:18 +0100
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
Subject: Re: [PATCH v3 03/18] cxl/pci: cxl_hdm_decode_init: Move comment
Message-ID: <Z8ltCiUCSagkpa9g@rric.localdomain>
References: <20250211095349.981096-1-rrichter@amd.com>
 <20250211095349.981096-4-rrichter@amd.com>
 <20250212180910.00005839@huawei.com>
 <Z60-UF3VGPsyqHjX@rric.localdomain>
 <20250214154955.00006b0c@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214154955.00006b0c@huawei.com>
X-ClientProxiedBy: FR4P281CA0288.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::19) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SJ2PR12MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e54c311-4924-4195-69e1-08dd5c92a3f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s+Tyfs2SvwKGPwJlka+MijYNjx/O0YY/yAXtaVDmIQ5gMx0FLefWW7whjaxp?=
 =?us-ascii?Q?VNVA9Agih0Z5Il+9uKltzimfrTrCTDpj9cW8lESxmj2zXIi5C8Ve6KC26iDQ?=
 =?us-ascii?Q?uIDK6JRNC8wc2Xoqrxt8FyOmcC2QhqRCU37/IZyjqN0gqobTKK1RFb9yilMr?=
 =?us-ascii?Q?kCWFLO242BWovnvibIz/D/3k5wot3gRXFuiqRZMoDYJszQ3MQQ+ZJ0yND7kp?=
 =?us-ascii?Q?QBCe0u+TM/OCptD2hCEWbP0e0HROHYSUlFznPE+tq+Ams1Yahp1kWZ1NgF3+?=
 =?us-ascii?Q?ZucyHqkLOBZoqKkiYW8EjAN/4HQEJT4dsn0rllfavJewg9O3vOxDt5Qd79PS?=
 =?us-ascii?Q?kIbroEcudRlGpwYPR3HOjnU2Rj9LMGROYU70BCUpYI33uIoQ5NxjkHw+oTN4?=
 =?us-ascii?Q?un5KOVFCG1JARJfK3e5AwY3EMWIWCbQNz3RWlYZgrPJYtrTnfK2qSCvIMhha?=
 =?us-ascii?Q?fVZc7douIWmEH3u2G/9a5ruH2Lghk7vCJ1O7TVL2htE9dXFkNuLux1nnKNqa?=
 =?us-ascii?Q?E0PeBEldqxI9RIwfwWHRTNHrtPlP5sha/uNwhZfD+xSBmcfp98tPc9DGlaQr?=
 =?us-ascii?Q?iMAmoDfYXxPoSDlHF077W/95I4UqbQ7uKTv90MtrbzoFFISEUSqTOw2BbuC5?=
 =?us-ascii?Q?V7fjGDkNPt6KosGxpKNGjgx417OBJ+JhCEhCqQ+GlVRraAWv5JTGJVe8wSCX?=
 =?us-ascii?Q?RKK0ESytHseTexxiMAQI8TXeZJRcQDWgWkCJRVStKt11jdgZxe/Oqc5vzhAX?=
 =?us-ascii?Q?FtC/t2u2/yxf5mbyDqzu48n8yIgou6CelKKbS2Qknd7mRRnokhuy6nIcrmGl?=
 =?us-ascii?Q?ME6CEyFvnO4n7GUl27pfX66DnQnvjjmOnunidwvcr2UTUgXWKafc7WTwBgDd?=
 =?us-ascii?Q?4vFmQVZP+2pzuxc5QLD6e+aeIVh4k2Jy6iUa8jTtpHvagU7mgzCqLzwQ1IDi?=
 =?us-ascii?Q?a9t+qmQUBm66Chfk4qhgAU0yg4lAHVta5MuOKfKBEmaBRYk5IlBH1raqxRDh?=
 =?us-ascii?Q?6JXH4+4iQykgpoZ0FY3/uGW0Vn0eL26H5c4MQTjs9qCBJxaSH6Ltr/HC9nUF?=
 =?us-ascii?Q?6Mqwb27W6r4zia9QTE6FAm1ikYlMIp87KfL2kWHejDIIjNBWhPxEw+4NkpGY?=
 =?us-ascii?Q?yERt79OmyZm/3QVGuDGRNrjfGthtt7SCdxx79rfOP1WyYi28abcjSJKDO/Wl?=
 =?us-ascii?Q?eNrnzB8Nl8D6wkiXPjmRyhL3TMW0VB4IXkxPkcv1MLBAo1JsRnbxx3dmz7eI?=
 =?us-ascii?Q?+ymD48ch4bEgfPRHov0tlaYr6Sq2fB5FmpkwTLmWORWbt9BBVlH4GNbxoah3?=
 =?us-ascii?Q?+FeSCY24AGXqTLpFFLTyY/LeEtSThGyOz13hPzOJgkP49A4N+JdOIdAT/zj4?=
 =?us-ascii?Q?yqJX4e/vouUdUoKPJj7MkTNlDD5y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q8+P7CgI7R1/+McMaX4fnhuwrZdL2Nh4iW9B2PaObtsokSmmATDC4yNd9Ek/?=
 =?us-ascii?Q?kiKeOBw4B0lf6KSTnk99dfxs2RT/eOJ1tD5mKJ6qyk3ZrgRSWVcNCSHSWEuF?=
 =?us-ascii?Q?jpty/luapLopPwFPrNOdXlUV1VF1PvSNY6Uwt8CN6/ZkMzrROhH77Hbj2Z+o?=
 =?us-ascii?Q?/uAQ9Zg0cUx0sZYqJXZ1xV3xaQX6e7yD1UP2Mh6rJjgtjHmkaXT5SjwrW9Qw?=
 =?us-ascii?Q?nAdah6zdDB74wx8Ma7R8I8fY5mjwbwjgyZWnYlN6t+ewQNxH+hv5yNieRmBa?=
 =?us-ascii?Q?PFLtYk0kaUuuh43U8HfaaliTyU8AEp5fFsT1OF4DwN23HrINtVQFIR1dF8Hf?=
 =?us-ascii?Q?mizWPTCKyJhvjBGCU9k0DpLohnf6hSWcJIGXLGCbazxUw1Vp39rX3/paGiQk?=
 =?us-ascii?Q?mPXTLyrdOrHRRzQEaPUehyHt3bRhlxrMIpZhcjxR59BrckFQkpsA8GwPueCI?=
 =?us-ascii?Q?ZBmaz78LSdHUY3jFC3WrjbifdeXTyfGOX0QHQz/mBSgCAZ8SBoxDSDLODjVm?=
 =?us-ascii?Q?GJ+nGYF7/KjrvuP8G2LvPXRYeqrGg27mg6V2whDz4ZCBm/IzQkOMjmHW7oLi?=
 =?us-ascii?Q?48CR6A8ENi/Mfr0IpCqqxIM2SEH7sYGWhxy0VoKiTSVO7OWbazOzxvTDcz6Q?=
 =?us-ascii?Q?uY3CaRL0CjwiaB7gB/havB9cNdBfFsmW+sSQD9LZTDAZjzClfGENDjkVJKr9?=
 =?us-ascii?Q?k8s+92Asty63p5qqhYEYOm2aRV5dJFw5LpxsLFeMAfn0PfUDQK8tA19HvV/1?=
 =?us-ascii?Q?WDM3DQ+dfrhCJc4SNzL3GRMAjHpiFm1Bf7W/YuT9BpfmR6mXI5XdGRGi30H8?=
 =?us-ascii?Q?MpcFuTybIjXe2kXETiocBYGop2cet286y0xAgmIBp708YhdNwI9oE/zvDT61?=
 =?us-ascii?Q?WiTLy4vIYUWUEa2giLoulwez9C2DBn0Dc+krIrB4Dm8G42jA5SX2LUbgU3OR?=
 =?us-ascii?Q?B2i6r1QRQ3h+Jqp6dY7MvP96EbOIDjAlnP0DnFGRNy/vzkfyVcV1Qke2CrGe?=
 =?us-ascii?Q?ZlvFGZZMrqXucdedLoM+b5qcHFWamIxZI3MmgveC73O7sYIZDZqeXwGw/AFR?=
 =?us-ascii?Q?ET28yMs6PfAiJW26uOPywbxJuocTfI38rwBGYT1jmP6vxzVwIvGf+CakjZmX?=
 =?us-ascii?Q?2lxILZJCxd+GfTRDqwRaQvAtppzcFk920RDRa7YVsbkMT57eaiCexu/zVf7p?=
 =?us-ascii?Q?9wFO9fDbRUtGVshNX6sElxqD/XGtOmqDGo7yFiaw+u5J/at5W/FaVp7EQO1q?=
 =?us-ascii?Q?X3ILobPCK7psC9dPlGvloE4SKwWSziLznU0UCIWqjatktZ4vj1bf8ECRV/8i?=
 =?us-ascii?Q?9aOqwnw7QWmV6+5w06Vvb8QFCecZVM1+Ks5wGp23SJE3AA8BkAYqHQKf2mTx?=
 =?us-ascii?Q?7/6xR6VBHDCxKSvtNYKFKqzoTRKrhlj9ujij7QIsP10+dfFiLM13gDWy/Ebr?=
 =?us-ascii?Q?cpZFPacQY+snng3ASiNOzgt0w+WBhEOhNFyKVBrGBxseVPyO5VtTuqR+lBFV?=
 =?us-ascii?Q?z20ySJ2wImylQvFfgHX3HjIsa4v9pdbEuz4E7lAGPlr9Nnr69ARjvRfcEPmb?=
 =?us-ascii?Q?vtDJTP88m90DzrpWmxQCtzKMu/5p+OtHXeHOAk/K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e54c311-4924-4195-69e1-08dd5c92a3f6
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 09:38:24.3895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5boltWYy6gCqTzt3satf90W4puN3tmySzi2dbgOedDccT6qZNG/k2VUAqHfA55nqx4NQ5taaF7MnqDkDmOFCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8977

On 14.02.25 15:49:55, Jonathan Cameron wrote:
> On Thu, 13 Feb 2025 01:35:29 +0100
> Robert Richter <rrichter@amd.com> wrote:
> > On 12.02.25 18:09:10, Jonathan Cameron wrote:
> > > On Tue, 11 Feb 2025 10:53:33 +0100
> > > Robert Richter <rrichter@amd.com> wrote:

> > > > +	/*
> > > > +	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
> > > > +	 * [High,Low] when HDM operation is enabled the range register values
> > > > +	 * are ignored by the device, but the spec also recommends matching the
> > > > +	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
> > > > +	 * are expected even though Linux does not require or maintain that
> > > > +	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
> > > > +	 * Decoder Capability Enable.  
> > > 
> > > This check is about mem_enabled. Would be fine to add another comment here to
> > > say.  
> > 
> > The next patch extends the comment for more clarification (I hope so).
> 
> Not to me.  It says 'else' when referring to what happens in the if.

I have dropped this patch and updated the comments in the next patch
along with the patch description.

-Robert
