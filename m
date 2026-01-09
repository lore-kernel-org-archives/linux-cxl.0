Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACB02EBDE9;
	Fri,  9 Jan 2026 07:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767943745; cv=fail; b=lYKj4L6c7dtOjk80SFSqMDPEVJ4jKDcMerET6HDMDG5S6XYYimgkfrJWgGavEjifgE/zh1awT00kZlSSZWhg3VY/iGumjB9peUDWkTYmPxVLSAW5cEaVA2W76HgiJ+K3ti2wzTXYn4snJhIPzDVHgZeZpgnfTQyOzWpadtY9ZFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767943745; c=relaxed/simple;
	bh=3Y6qpD+lOl2YQv+5TDjK/b8LZ3p1WTfIB/y2de5UCEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KpmBQJz3HrJFZJqomqFrpUUSFTix+nEuQyz8ahbM+3P2/w1sFsQf9szQHiNEttX+monItWe7MonYMr+E3BXRK8G+RK8yaYXu97zLn2pbykUaegIgszL/v9l07GaduY5jzkoKoQzsGrpaxpTs3jXYavw0Kh16+N95X0qBpj1SYYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DxVEeEJh; arc=fail smtp.client-ip=40.107.209.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DxVEeEJh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bkq/9PflqJ1CMkYevjP77QiVBYt3lim9xwvMZWNVdBQbI/+RkJNgMMVFXqLMBegBQ+1WqcoxNH/1/IG3UVDGXP7WPibJoic1OLWu8/2P0PyA3j/1j+vXuzV12J8L/6QiUUY7ZdCTsFaB5lWTVBMeDve9+FGKaHzRVyhtnMjG5iobTYXn436AyiLQRXijcrP1Fxd3y9unzaA00CabtvwhnE07zR5tuWju/b6StM9DiEsgvEQgzmmn6BS+080jY46PWNwyxFe6FrHhQgnX/dIJ06k6Prrtxq8Jyj6Q9ZpSZtbtBdPTdIIF1CIaezNKcXB+hqiLtL8OlrhurA9m71rvWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFqZVCITIJehuc9FqeiJGV4S8Bh5sybKHwGT9HDG/7c=;
 b=t+rQSoQyppv9fnk5EE+/I0iBIFKP0dQAxG1ETnhjrOvgXP7WLxQPJBLKMSUKOpvgCFZevEU27xDaRd7vjWVLTSM3F//a1tFroiwXsY8nI2H6LDVfkNpJZfOWVOM89heOPOBQMGxjP8KxPwbtoCIkDaAWV0qeEB3orPTANKliIFfzLnbZ8wg8IY0pLmTvM1CAlxVIRjyLH2E0xdgP3I06r4Jc5/GZqah1vg3eFnZVDsrAhu/FAbxdShMBqNZ7UKMhACyaWFjrSvCY52J558RimqtXDewY+ikwoSj6uqKIOwxn/EwgDMfYZg3XlCmGX4y72kdY2uFrktzF7H5AZ49xOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFqZVCITIJehuc9FqeiJGV4S8Bh5sybKHwGT9HDG/7c=;
 b=DxVEeEJhpIrV8s7XvEZCm+2WJyJKSen6lYlwkI5xVq6w0PQ7jV9d8SCaImlC4pEI4aENlRajeMDKOG6G1ugt8FdMfY4VxeHaov39VEiml7DiwKn0VKp4oZZPd64GExqpF0GQzPuxR2VdS63dLZFfIQA15LV9QS2aMFchiW50ytg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA1PR12MB9471.namprd12.prod.outlook.com (2603:10b6:806:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 07:29:02 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9%6]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 07:29:01 +0000
Date: Fri, 9 Jan 2026 08:28:56 +0100
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cxl/port: Fix target list setup for multiple decoders
 sharing the same dport
Message-ID: <aWCuOIFIn7ZgBmiW@rric.localdomain>
References: <20260108101324.509667-1-rrichter@amd.com>
 <20260108160835.0000092e@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108160835.0000092e@huawei.com>
X-ClientProxiedBy: FR4P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::6) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA1PR12MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: f3982f9d-0e2a-4a76-fc5b-08de4f50c2c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pzZ7kNsVJPXWvqIZi3LOF0wMVrZNxm9l50e8YIuE3UB4RasOWZ1zMRPR0UIN?=
 =?us-ascii?Q?3eK1dtPboLiBAMOGsTOAiRCBwfD6+ma/beaKYRDsrFE45qxQ0fWBQTZbYpKB?=
 =?us-ascii?Q?iJK9MEtpb5EG42Qfe004jhcXKQsfF9yKjVreFeY4uNV4Ci8WkO6LGuMUfIxG?=
 =?us-ascii?Q?p6Ksw5jMsIrRabf5or0eRVXoGhy/DH7t1USRMvQEzbUey9k6EoShMUYFiuFX?=
 =?us-ascii?Q?iIDODoKRFRIAbUuv6Myn0H9LVKSzeAeWB6ku7qkmgpCMC6WysDvbyI6qcvjs?=
 =?us-ascii?Q?SfArQPCF2xCuqYqhlepAjrDtCG/aiLm4597TVUhPjF5dfl0Dm6r4yzIY9eGQ?=
 =?us-ascii?Q?Ay+7gFzahXahoBLbw+7c88qcmvi04AZpYJegDBY+cgX7mjBo0cC2F/8lFd7L?=
 =?us-ascii?Q?lyWMK4+DBCROXdQTP5PXXFCk18l+79uAOSrVvPmU0dYdlJxcPROH3Am0I9zj?=
 =?us-ascii?Q?zj1v5sh4ctSyNeCtvApVKG1sWjKLBqa4tZIdUlUpQM96v28JA9BUcz5h9gMw?=
 =?us-ascii?Q?VTQ28ZAlcucFV7hotvzzGijVqbY+x9vorX6q6A8Jw/nBqAcdjJ0QB2/Hf8s0?=
 =?us-ascii?Q?CdgL0cGEaYFfUEhs4AJIeNfueszDbKdXQKabJWPKLI8r24RVXUmF+Ol+x5Wp?=
 =?us-ascii?Q?eOAAkp4/utYUEiw9SLoPZfN3By5XBgfN1JeiMarZPWdjPorOJMkg9mcxZVO8?=
 =?us-ascii?Q?5Cubl6eHdmofA1VBG7Ct3/FUTV6T9U8fUmLqZ2YCV9AJ1ftK51R4uOKdXkZx?=
 =?us-ascii?Q?88/ndYVYc15+SxtsNX3ds2zeAfvqgQd9esJ4MYQyRumhNGMI1mkOWNHS5RYi?=
 =?us-ascii?Q?xAlA0e36WCXCOEuu1kh9h3zmIDmqPD+im5Xrbt0KYNnUGRISaf9dFcwdanPB?=
 =?us-ascii?Q?QQZrdmpckiDYRTk4I4MG0puAbzaZV+4nVKdlkqlnikQkzsNBxQgghxIIqDHx?=
 =?us-ascii?Q?RiAtt6spIHbgo5xu8bh7rldbxycPGgfmKzUz9ub6nXnfOvS6Qbaqgxwqk1Yl?=
 =?us-ascii?Q?qzKJ0nKHdnARXV19mESiCzRk6BhPaOsqkZhsK4cvM0vQXJybcjy9D7idC/6e?=
 =?us-ascii?Q?7xLHAtRn0DmjS9KLFssY0GOrbjZmeGtcO78xAdANCsgLZ9iU50sdqqRNXsab?=
 =?us-ascii?Q?9IzIFmVlf/XV8+wt+pGocB+Wrz5Dfmfzw3LsQSbmzowdDmtoZv0gJr51jKtm?=
 =?us-ascii?Q?Ks5AJHCyc8CrNg0tkIwwuscAgQHaCXbj0bNIfsEAfuV00fmyGi2MsVdono5v?=
 =?us-ascii?Q?wmIg2QBG6MNCsjXFWscHTR5HfihbkS8Ji3G2+RkUiQwNYGSJaa5jSP7wbsae?=
 =?us-ascii?Q?bMf76lVWKLaJg+mwESEMvmTZPf0O6um5y2DiH2qOQ+k1Usl3tcyCxMQyjziD?=
 =?us-ascii?Q?Ku7cykkHEjXtsFCbg9HUGjhBnuec5Ea4cUiupFvYViBG9Da5b2XAlm+fztFc?=
 =?us-ascii?Q?avFBq3wjCDG05KXecVy687++OfoBkQsj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZOwOXVZX1G+0ZppSiTdw+RRnhrRmwPS4BQEo8PUFSLO+N1eD67AIckAIv6iD?=
 =?us-ascii?Q?QKlirNoodBmyldZRZKg7hgdoQSPLYqz7TQh1Uj1mMKl8M0OkpDGIvsc/4C2C?=
 =?us-ascii?Q?Bd1XsyWDpTvhjrPT5weoME1iPcnbY6mtA4PM80I097Qi99yARHMEb9hs6sYo?=
 =?us-ascii?Q?zsyE5QMocQxjCWAWfCSsW8y5lyURfncPyCxqryUx3vk+syq7awhmMF4uUg3e?=
 =?us-ascii?Q?M3DdR/G+7eVfaU11ENRu55ZeVS3tRoMLBxfxVRoeaI5VGL/et2VMXgwOkUZG?=
 =?us-ascii?Q?MFDGWn9VMwINV9mqVXYLc2B9TOzgq6XJfqlKCYQgxYmyPmeZb1xQOO9vd0iT?=
 =?us-ascii?Q?LY5DnQcZpQBORa0kNj9No5rwTDvBmWFN9Q945VjSez2mdIMuV5NJcXuIIgu9?=
 =?us-ascii?Q?iXFCMV3tyRZrG2kkYKjfri0wamQ8iQm8M8AaAZHH5IWFF3VWoOxg5kvXevKB?=
 =?us-ascii?Q?6LC6CsqE8vE7Of/Y/WizPLNQmLs2IR29ef1RYUvEX1mFWn/HN/DVQraLDRiB?=
 =?us-ascii?Q?+MsJ2Qn4qbJAINK0DYtPrkfynM92bxLZ0X2PVd2bSkqxGz4EPYCCgcMtKkPs?=
 =?us-ascii?Q?KmBwVeNsc/Jq/l/lP00Y4uJdjCauRahlc2Mu/WpLa4VaCFf4KQXXENh6nGtn?=
 =?us-ascii?Q?GXrYf43d68p9DyB99ygwpnCKZSYSh7ThU2D1C2eH9yhU9StJQ76h4I4c8pJe?=
 =?us-ascii?Q?jZJFa5WZJlvSwD0fqREBjYk0ewQoxMcmCsApFfIt9fuqlMpGHsr0pcDEvv0G?=
 =?us-ascii?Q?z6oZdztNl9IwgpRsU9jMgMTRxhqPbp8bgvXThAKmAgucyMDQmRoKSzX41yqz?=
 =?us-ascii?Q?XIiUHam845TFvbGP33wM+bSUHcqc1LzEbXOhudLWcUziOWS4cxfxihlumKDy?=
 =?us-ascii?Q?HgkVPMFtI4igMwthW9YeDrU8o4cO2ZPsUSn9baaieoH04t3j5hhgYHCzSjC3?=
 =?us-ascii?Q?Bxhd4ikGksalPPaJjQe2q9RrrvyVVICwRvF1jZQkd37abNs6CaYXX6NubuuQ?=
 =?us-ascii?Q?sg+hJv3dGHA4Nleg3wbLQrGclCwriJHEpSNPY6AWFpq4rt6dgY9ZKU1YTMP0?=
 =?us-ascii?Q?fCfei3zxefAfR+n8YtFo5bAZltWbrKWy1S5c9C/3QPPah7JNl8AXLbI7pzmp?=
 =?us-ascii?Q?1aEct7SqQLYaDHxlnPXMItTj08VXS+AeVc+XcOe2wkUlwI/Zy8qPmm9z2P6B?=
 =?us-ascii?Q?aIQ8ZS9xyz5XA929lZXn2En49CrQK6Iah57clihDCnRXQeNA8ztAQXNU73BQ?=
 =?us-ascii?Q?vBhK4xOlqp/TAxmj0UWFJB+Yh8k3kf/bYjGaE0AmxMGdjZT1+HppiOm8flm3?=
 =?us-ascii?Q?zULq7cJm3YevuBA7k3w29CnKtN4UT+f93Sd90XjTPEeDSW0xcWxQisdDCzsa?=
 =?us-ascii?Q?cYSN9qLWgS1DQkgZbei+ybuY6Nb8Jo4vQIJ7mkLuIcIMTmSeVC21He8eSaeM?=
 =?us-ascii?Q?wCkA9bdBnhzhABj9qITDNTRbjgqDopa/hB2mVmhfG1Zl1KU0RvVPaTQwj4ln?=
 =?us-ascii?Q?RNL/xS4E7zc7H0Mux63nxOVj5vyGBtpljkwspd3hT90er1eOmqHbcN2bgS3i?=
 =?us-ascii?Q?dk3KEd8e+QXs7AqotUlksdY0nUre5SYXLNji190iqJmIbFUHx+URyoCrM+nc?=
 =?us-ascii?Q?Q1boRttIC7ScrqWIqFDOQTCwWQsIw/uYt9s5OvdYLxGI8AVRxynBxZgCYrO8?=
 =?us-ascii?Q?8RYlEOmgwyU9W0tKILRv0LvVfYQ2AGVYesSySW7r3g33+d09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3982f9d-0e2a-4a76-fc5b-08de4f50c2c2
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 07:29:01.8722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RoxpUbZrhdH2XY3G3DAAqL3gRTFTVfdARWVsM1s4xB5qASSEHiS8jtMf3olDQ7zB+YiF4C4j7Z5ulvgQtgupdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9471

On Thu, Jan 08, 2026 at 04:08:35PM +0000, Jonathan Cameron wrote:
> On Thu, 8 Jan 2026 11:13:23 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
> > If a switch port has more than one decoder that is using the same
> > downstream port, the enumeration of the target lists may fail with:
> > 
> >  # dmesg | grep target.list
> >  update_decoder_targets: cxl decoder1.0: dport3 found in target list, index 3
> >  update_decoder_targets: cxl decoder1.0: dport2 found in target list, index 2
> >  update_decoder_targets: cxl decoder1.0: dport0 found in target list, index 0
> >  update_decoder_targets: cxl decoder2.0: dport3 found in target list, index 1
> >  update_decoder_targets: cxl decoder4.0: dport3 found in target list, index 1
> >  cxl_mem mem6: failed to find endpoint12:0000:00:01.4 in target list of decoder2.1
> >  cxl_mem mem8: failed to find endpoint13:0000:20:01.4 in target list of decoder4.1
> > 
> > The case, that the same downstream port can be used in multiple target
> > lists, is allowed and possible.
> > 
> > Fix the update of the target list. Enumerate all children of the
> > switch port and do not stop the iteration after the first matching
> > target was found.
> > 
> > With the fix applied:
> > 
> >  # dmesg | grep target.list
> >  update_decoder_targets: cxl decoder1.0: dport2 found in target list, index 2
> >  update_decoder_targets: cxl decoder1.0: dport0 found in target list, index 0
> >  update_decoder_targets: cxl decoder1.0: dport3 found in target list, index 3
> >  update_decoder_targets: cxl decoder2.0: dport3 found in target list, index 1
> >  update_decoder_targets: cxl decoder2.1: dport3 found in target list, index 1
> >  update_decoder_targets: cxl decoder4.0: dport3 found in target list, index 1
> >  update_decoder_targets: cxl decoder4.1: dport3 found in target list, index 1
> > 
> > Analyzing the conditions when this happens:
> > 
> > 1) A dport is shared by multiple decoders.
> > 
> > 2) The decoders have interleaving configured (ways > 1).
> > 
> > The configuration above has the following hierarchy details (fixed
> > version):
> > 
> >  root0
> >  |_
> >  | |
> >  | decoder0.1
> 
> Hi Robert,
> 
> I'm struggling a bit to align this with the above prints. Where is
> decoder1.0 for example?  As it's below the root port, I think it's the
> host bridge decoder, which might be this one on your diagram?

I only showed the detail of the setup that was failing. There is
additional a 4-way config (port1/decoder1.0) and (not visible) some
1-way configs. Function update_decoder_targets() is not called for
those.

Thanks for review,

-Robert

> 
> Fix makes sense to me.
> 
> Jonathan
> 
> 
> >  | ways: 2
> >  | target_list: 0,1
> >  |_______________________________________
> >  |                                       |
> >  | dport0                                | dport1
> >  |                                       |
> >  port2                                   port4
> >  |                                       |
> >  |___________________                    |_____________________
> >  | |                 |                   | |                   |
> >  | decoder2.0        decoder2.1          | decoder4.0          decoder4.1
> >  | ways: 2           ways: 2             | ways: 2             ways: 2
> >  | target_list: 2,3  target_list: 2,3    | target_list: 2,3    target_list: 2,3
> >  |___________________                    |___________________
> >  |                   |                   |                   |
> >  | dport2            | dport3            | dport2            | dport3
> >  |                   |                   |                   |
> >  endpoint7           endpoint12          endpoint9           endpoint13
> >  |_                  |_                  |_                  |_
> >  | |                 | |                 | |                 | |
> >  | decoder7.0        | decoder12.0       | decoder9.0        | decoder13.0
> >  | decoder7.2        | decoder12.2       | decoder9.2        | decoder13.2
> >  |                   |                   |                   |
> >  mem3                mem5                mem6                mem8
> > 
> > Note: Device numbers vary for every boot.
> > 
> > Current kernel fails to enumerate endpoint12 and endpoint13 as the
> > target list is not updated for the second decoder.
> > 
> > Fixes: 4f06d81e7c6a ("cxl: Defer dport allocation for switch ports")
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> > v2:
> >  * updated sob-chain,
> >  * added fixes tag (Dave).
> > ---
> >  drivers/cxl/core/port.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index fef3aa0c6680..3310dbfae9d6 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -1590,7 +1590,7 @@ static int update_decoder_targets(struct device *dev, void *data)
> >  			cxlsd->target[i] = dport;
> >  			dev_dbg(dev, "dport%d found in target list, index %d\n",
> >  				dport->port_id, i);
> > -			return 1;
> > +			return 0;
> >  		}
> >  	}
> >  
> > 
> > base-commit: 88c72bab77aaf389beccf762e112828253ca0564
> > prerequisite-patch-id: f44102a7b095afa1588a5cac012ec2e0d852c021
> 
