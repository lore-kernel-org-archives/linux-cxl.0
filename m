Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC9B1E486
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jan 2024 22:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705616287; cv=fail; b=oOzPb2/arYANzvkHIQQTFP6nn3x5a6KS26EeF7w0IfV6N0lJ3dz2jD42wZKxVEhMA1kLrRUumBQv3nNt1WdO7D0Pj+HuYJB7MNdjm5Jt7SKhbDI5eufhni1OtJxWo5mgwO2tpVrtKyNptlCkWV5qiOVlnMFpClFWxPE003jC/nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705616287; c=relaxed/simple;
	bh=b816rcJMcE3IPDqh6btfFaADad1dJnOeSXApke9ZSSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YFDiD5TtyiZjAjzwjkbX3gEGYbtC/SnEndBBGqKnfSLl5dOR/xXc2IOFFt7myGfginM1NEPUjAb9OaZOobGbCtOAhc0ET7m5G58xCX1Gx4LHTU2/+zmj+qi4ghmwbP+2D+FMvAMcSAEzci16WskTH+mrk0qkKDs+h5wJR5KvcHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sjNh/48L; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sjNh/48L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnkSpNCocrim6yJywYExYiWa3beTwkCtrt2bgzr+avWjGu1/XVjl0ZqSf58jxvr73NSoSFipLrpiB80UmAmp6C+/sb4PIGgLRUDs7zWwP3IwlFs7Od3bLGVK5ay9XjprBH9veYi2wkzXh4c7bcduufrxy/capk+ViKWmTp/1qIf7W8gM9zKWpn9ZWW9ecvEKVuq4uQ8nIJdZBTRepT340nbewJIrJid8Wirkzj7iVzOyeWSk9Vnyeck+Mw8tNFGRGd1Dk7eQoacC0t5Qa1f3DdRXy94FGZ9HnR+TZAuUopfaO6Nl5atpxCcy+5LI7gupVM+SY1LMRqqbYqUDKhg/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEIrofcYZ67xD1lewC7rDejVuCbYGlXaXuCjrPaMTTU=;
 b=n+7qUoYkHNr9ocQb/vr6vT3/MbPPquCzl/X6pqRTZK35wJham0oifEXCt4lHAq8d7KJsh+H1tpDukOBoe38WaPEAWU32HuqGimQ/cJpY04s0vIMzx5+QRyqPtMCXdDiwNwRoirS/btJJJvPC1aX5x5gLiPIWzFyvUegbY4nRRrYVkg0th39VwiCLDrL60N1h1uFRIyloKwIH8KGW6jHsw/lJ0HpGWW3sfuWcDPkD85O2fMlESXkUBkI9jxfNaHhc+njGKOFKARmQNvVbh6LPV1vhpCrnmjEDG6tqPYlRK4MrB5JxUGkrkLSVvaxAMStcoOkGNVS9ESIz3+STpFdxYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEIrofcYZ67xD1lewC7rDejVuCbYGlXaXuCjrPaMTTU=;
 b=sjNh/48Ljh06+rD0qXh/KG7KAznBC4pcPKxUDmVhvwtfoDGdSjvgfzJ++X1nVbISXufyRbArmwAJDnDiCdkhGeNpInRnda7u040+Ffq+kflWP8tWIMNMjRh0QKBSAJpIvTIjtCw2J8a1q2PGb6cQLHI2hTnIupG06FXEO4eamsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SJ2PR12MB9007.namprd12.prod.outlook.com (2603:10b6:a03:541::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 22:18:01 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::e46e:7c32:7556:fae1]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::e46e:7c32:7556:fae1%7]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 22:18:01 +0000
Date: Thu, 18 Jan 2024 23:17:57 +0100
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/pci: Kill a goto in read_cdat_data()
Message-ID: <ZamjlZqPBeISLjAQ@rric.localdomain>
References: <170261791914.1714654.6447680285357545638.stgit@dwillia2-xfh.jf.intel.com>
 <ZafUwceT4N-bmS6F@rric.localdomain>
 <65a81a40cea43_3b8e294ee@dwillia2-xfh.jf.intel.com.notmuch>
 <65a81babe2436_3b8e2943b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65a81babe2436_3b8e2943b@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: FR3P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::15) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SJ2PR12MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f2abc0-c14d-4e4f-fb7f-08dc18735588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NGQMVcE1T6qdRxMJO/ph9CbeaAjfSl4cB4cu5YXdVAMceqTxBu9AuzuLHWQql3GiwIzjxtne0Y4y/HNlc4RF6xu1ZnMgOrfQGWlDvB8xu2HUZEEwOcv3VAJNdW7eLcaG+fb6BhZx+3NWdLLLgu57l6HDTH7QznEMfYWuQw9/irv5dcds98/X5N2PJlXQlGHO8ZKv3KbkVuhTu1G1OaPijGgIHv+b1oGGlEzTlc0tGeF+aN2Ffzc8tvh/1gQNe4n1EZWjzor507z6ScgnhJhkYN0f3zLZHJ9oGDi8AABMavSENUk0EqVd5uvtBjlcPluju7s2g/c1bhv/V7h6+xj1f4YFcbLFVyZFrzI/Hrk6oHi4o0QkOtb2FKWX2LIiR7T0JM5WW44zjjGprUsIIM9JJyNpYvoOOQ5AVU5fR+cqQj3v3J+ONnfvd8FRPk1Zh/ymHHA3asqPL2BGXCUWG+I2Mgbgj47/QyKXk4uiTSV84CZSgdmdUhEpQLUkr6wH4Xzx7zEByVN67cKbADuYHvGqYVlUOmkBP/VAdOlmEtNVtAY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(5660300002)(8936002)(2906002)(4744005)(66476007)(66946007)(66556008)(6916009)(478600001)(966005)(6486002)(316002)(8676002)(53546011)(9686003)(26005)(6512007)(6506007)(6666004)(4326008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y4QnxVVLg3TOSmcgT7yT3W/7Avl7sQTIZCNo3YbTqhtAbiW0X/yyMmCdlXbR?=
 =?us-ascii?Q?r18ZJF/njbAf5JTg4nY7Q38TIm1kGmH7DPxei+SlC1g6/uQBdeJCnECnQPDo?=
 =?us-ascii?Q?MDWauvGY9mEiOzA/AQqAW7a9rFhKVb64ylGK/drQT52G5/uVDTbHFY+WWAx+?=
 =?us-ascii?Q?jbEiV/vBn8AzmSz0Im48RZX4+UkWYoVQilPRruTBRS73Cg5iQO+kObJ6zh6E?=
 =?us-ascii?Q?5ZgADIjuINUXdKFpL5f40sw1MaLLMicCeKLxkiEjWNahrcuZonmGYygUujLj?=
 =?us-ascii?Q?/ohpMBglbLc1fuAGIOcaecAiRzkE1mYtyjNBYGhsYWrBlQqfgnRO1DsrYK1m?=
 =?us-ascii?Q?0bPIGXzGRq8xY51rWR2vEXbAQbOzem+U+GgMnVKDWaaLRXnX6BUqY7dFukKt?=
 =?us-ascii?Q?UpuzQ76RTQZ6J3thz6HCw2ydeqq/9XliGl/NhxMhpA5MzlyuEF4Pwq+rJQyI?=
 =?us-ascii?Q?5xloVTxzkXe1pnpvsYhJbfX4t3PugJhBaAifK4RXnFsWkaR3blybx5Q1snGg?=
 =?us-ascii?Q?vjfjih0uG2X2j/+JVzC5arESuWcFbVzzc//A7FVll4sCUyPoaRRcwKzXE/6l?=
 =?us-ascii?Q?OrgyFNVhTyA0umhFVEeKJdTz82gH53/IWNzV+dvlRqIFtZklGGKsiMOMm84y?=
 =?us-ascii?Q?SYZtzMf0xhbIK40yuq2jinOdGcOjYDYAO9SYVOmLptzXyr08GUmtOWofgZHn?=
 =?us-ascii?Q?u8GHNjfRdp74314Hrn8sOMx3mImjm2k95droF4HNvGS6+dKK4d4uh2ATrIdS?=
 =?us-ascii?Q?3tPPrIabjkVt/KV9YouDvSd/17F2T/+GdhyJ8tSzzNuuxjesWEuO2vz1tjsa?=
 =?us-ascii?Q?CL+lmrhi78raQ+BvR9OoM0mfSDJxWMbr2XXNN9kEyI5hs2X4M3Gtw2NLM0SQ?=
 =?us-ascii?Q?Exjlh9VPre1CwqlaKvPGMi94OkfGOq/UFDG4PKrfEKEc4034Y2+NCo0Xdn7Y?=
 =?us-ascii?Q?nJYFDvgkaCWVu/43kOcoeckuqoeRzEqF5F+x7QIWYleB5InnZlRZgo5QuLP6?=
 =?us-ascii?Q?OdCpilXmxuLhJewcMTalARqcCjE+jHlc4wf0Irx+iJHYV7XXw1E+QPYX6l6d?=
 =?us-ascii?Q?TD0j7jXxCf1JxWEAdjpFOxziCHUp3mcP2Wubi2zIOiEYkaACwXNSFWtM7AwH?=
 =?us-ascii?Q?7NxQvT31fVjzUoeD0Mv0wu8Z5FLvQGg9QNeEvpMY5Cf5JXXkSX2wI+pk8uCr?=
 =?us-ascii?Q?uFow8l/VwWXNB04Uilxfq2S8T0ocFSTpFSHilRVxRxdn1sAbNsXiRBfEUsoQ?=
 =?us-ascii?Q?VTwziz/XKSleWTX9h9ORu7e2CZDTc8HbK07Z1UN3BNPhY27NDshtPUD6AOy8?=
 =?us-ascii?Q?OwFLw4mMo9r0zdC70MB5HTBpwDGFAK3XDMQjYkM2AIZVwPSjW7EwkzqPr492?=
 =?us-ascii?Q?W08HUp1WMtp1AkCdXj4rLIxr7xs3dp33V134KYpA8G0KgcJs56qdm0s2w6oq?=
 =?us-ascii?Q?yM5BYx4WNMrR2m3agmzWe737YfI006JBQbAtkB5EAnWIjudifzz1QFPtYQYN?=
 =?us-ascii?Q?FcO8xNgrDZKMDKBKwR8BWJdrjHu1YQapC41YcGQGgQaXEB0PfTPaFVgWumus?=
 =?us-ascii?Q?Fa/fqZwqsC3e+HxNQejkHGI1TR95IMRpJc6GF6at?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f2abc0-c14d-4e4f-fb7f-08dc18735588
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 22:18:01.6458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmQ2cJjlJdb5jUwQ0ijsEuPDqH2Ftcrw9Ir3isk4pe2FMD2etbmsJ0trfoSoV8J9QXs52h5iTRD/7tmYLYRw/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9007

On 17.01.24 10:25:47, Dan Williams wrote:
> Dan Williams wrote:
> > Robert Richter wrote:
> [..]
> > > Should I rebase my other CDAT patches on top of this one and send a v3
> > > of it?
> > 
> > I would say keep the goto for now because your cleanup to eliminate the
> > awkward "cdat_buf + sizeof(__le32)" makes it easier to use cleanup.h
> > helpers as a follow-on.
> 
> In other words, I drop this patch and await your cleanup based on the
> current baseline.

Posted it already here, but burried in the series as I split v1 and
added another (unrelated) CDAT patch:

 https://patchwork.kernel.org/project/cxl/list/?series=815050

That v2 is already on top of cxl/next. The first 2 patches can be
applied individually independent of patch #3. Please take a look.

Thanks,

-Robert
