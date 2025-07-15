Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9528D2FB;
	Tue, 15 Jul 2025 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574465; cv=fail; b=GGmMpLQMdE/hhkzuAnQiAri2DHw5IP/cpSHwNzNgtg7tkK2HCIk/Utu7MSiCQKTpdmGtX9xPeqb/5SivjxZeKg0JfFzkk63esFXNcm9yj+cJqvxMVkydaKaXtYYrrsSMOwjbd9UqVz+2PB6b/1+Oauv4viZ+WkJtqS9Vrfvy0Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574465; c=relaxed/simple;
	bh=PonHYWAOGEBhwANyV8JW8ZURiDr6qYiyMunvsw81YZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ejPjMsP47pV+EAH0oyP6VPARPWKYMiGo9iiuO1vfWgR4iZu/iroLFrVPDGNFu0Uyh+OVOkPM/w+XemndudkkTK3KuaicAVvG5R0N7QjIuMs6PYur9iyyCmnqzlWjVMrg3838xtAsPz6qQqlhgUvclt1onVzNuC8qUyLvVvaxC4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jrpaswpQ; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jrpaswpQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCiEWHd0tZZFjzewA7otlaSNO91uYzqs5iI5s3cAODqLegyDhNmI2QkRkbbpPZSXUGbJGU91G0v/iNDus2BXnS0mJzR8nJI8x6zZMdzvqC6fgei8jpMNicNMnN911pb1Pc82ZrbP/nfD2A5ax7ine+c/hdw7FkL/1TOKNX1kgbbZmWSy8nU8Ku0P2bkW+vzrzCmAdUkgAs2MchNrqcOpF8hJIs2dH2IZWC4mN3ADVPjQeAQNoJ+B4Dp8UEv80AhSAqSz6X5ZjT5gus+QKUTGrVBoC9y2EZCXTUrpBPI6ItUK75x78lsaZZZ9UN7t2ovgQpemq5N8PbHhEosaNgs6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yVz02Ixpua3nV2Y9H+USFtjjSOfKaWUEzhU2Z6dMTo=;
 b=D9CMwbuaHqnZKACDDs0GH8y9bo4XjAgfCcelDt3+UtcKGjlyW6tNzxM0K3GD/AUx1gXQUVxiKduhVPWfDoF1JKlubyu4wnl4FYA2oGFvSdKBDbCT68qcESLZMxGFjTTC6BMxlacstx8b8SoUjq3Ew9UEfGf2Nomqkd1zR06R8VMYb3EdRdEhmNnnfZeof6UC9md+GSbgoyFVwjkrqBvKDXc/RDqawtSh6S3QL+FiauEaj4Jr7M4A8GN1aoZ6bYnKXb6NtGxxnnhSibA8I8jhpVrwdkxixuBYwxAY7HUYUbkd+8emV0ThOcfokHsmVtu53F1MLkBRSsf+vNlo7dhMpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yVz02Ixpua3nV2Y9H+USFtjjSOfKaWUEzhU2Z6dMTo=;
 b=jrpaswpQyMOx5QXMcxsEBtKxPDI8FM9//TVoF9epqnHyTxozytUbCpeURUD3bTojr6fQI05BqYfPzQJBVhLxd6C/eckexrf8XFm35h8SS+mDUVUArg6OUu1XXaiE9UQ1UCDTcvbw0Fn1Wi/ZlIs/Er+2r3sSpHPLcDYtMOUAjE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by PH7PR12MB5854.namprd12.prod.outlook.com (2603:10b6:510:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 15 Jul
 2025 10:14:20 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 10:14:20 +0000
Date: Tue, 15 Jul 2025 12:14:14 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl: Remove core/acpi.c and cxl core dependency on ACPI
Message-ID: <aHYp9g0H4efRRIZ5@rric.localdomain>
References: <20250711151529.787470-1-rrichter@amd.com>
 <e337a408-9c29-4990-bb74-d65f1e523998@intel.com>
 <b1f44974-0609-4697-bada-9bcf27f7df43@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1f44974-0609-4697-bada-9bcf27f7df43@intel.com>
X-ClientProxiedBy: FR4P281CA0270.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::20) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|PH7PR12MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8f830d-22d5-4492-ae94-08ddc3885cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b2Xldw9CVfEIwQQdhcXGXFyQu0Fc42UrP4tZVaPXdRre1eYd8GodZz1qz4DZ?=
 =?us-ascii?Q?rl+jkCKa1VQ+rKawPZ+DCAidkQ2ZKZieoi6xoBbcwolxH0jVzu3SMSWvGu4G?=
 =?us-ascii?Q?3i5oBO4HGPeqmgNmmbLGnalPfnmAKyP6JB02MuJZB3ahdAAQyUvaclhkMCNo?=
 =?us-ascii?Q?qJ7qjyKqBiRZf9xzipqqfuXCsWAANnS86lsyZJOf48dlpAHBAGiRG5Hmn4hh?=
 =?us-ascii?Q?7KM+mm8ey8e7pXLMKtGT7xORoT2ef37NCUNr3SggPnKRTUHVTm0QwD0dOvsu?=
 =?us-ascii?Q?mkzwLjL7/LMjhkzlQ1biUDNEOPo7wpSi5WVn0YtX0MDYum5j+XVFHQ9cURjY?=
 =?us-ascii?Q?xdammFa/u2YiFsuvUSZjb9oaKEzGAcUz4ZQnQJ9JrI4ESmBaU8x+Eb2uQwBv?=
 =?us-ascii?Q?3ERPEOBF2CPWdNlfzj3Gacd0aOhbwNbgqV5uvbepakCDkeSYGDSkuFq8Awea?=
 =?us-ascii?Q?p3dS0Dn1rI02SGOz1gkj46hYnslw+jLWuiF4VeGI+6afgQh+d/kjRxLhHZTr?=
 =?us-ascii?Q?BYw1ZK9bInAabZYXoku8tu/En2+BvFkuHfk0b0MOYv4XdGVnjqvaUFAD3Nzs?=
 =?us-ascii?Q?zhFiNtVQTO6zoHrbuUble01mr3as7lCnICKZYfV3Qm0rc1V5M/6eg2B7lBNZ?=
 =?us-ascii?Q?MDafLD0J4voJSTz+hi2TlvfSLcLlUZofDdshXoRa2dYeJwVNcoxzGOw/mMR/?=
 =?us-ascii?Q?6THIsLv0nKUHNxz73nY9V8NEivu1T1EqzetUMSWvaZgAsXQTPw+q692dEWCh?=
 =?us-ascii?Q?lKP2lbO9RtPs7ZeUZtkYuE4Xm3z09aYLtrq5GUT7RjaGNb+KJ6FrpPZx4PfQ?=
 =?us-ascii?Q?vTRPiHvscNPbxVpa6Qs5/uM8wVC584CP+udlGPDfSipWRYq/BC3xhfFHYukH?=
 =?us-ascii?Q?kNiabglBpJs2Lxy1pVT46ZZCr9sT1pfWuBsYjB7VI8bTGiLQ8J/bRJSyk3b0?=
 =?us-ascii?Q?Tww0JUv/hQyGRI1+rVeQV+dtcj+Rr88aWG+JdlI3iaex9IrsLCAgqpe19ciF?=
 =?us-ascii?Q?Ww/Cq3WmA5i4I6qp0ShnA7JDWcweN9vSrj0H0JulUamw2MdsV+Xbz4arjUJf?=
 =?us-ascii?Q?YK7/x/suMv2ueq9/sUNNrux1NYBt4B+1gS44rWfLZusNiq6MvKQDdE+P7GUA?=
 =?us-ascii?Q?w0D8c4WI6rIsvm9gvdU4+38s3eC40FvTz4vC7ImPHLobeS23tjBKgKfL5eI6?=
 =?us-ascii?Q?WiuvQAPgN7osPH8nrbBXySM6ASKaSbFVx6ijWvQ4JOODDGp6EWj7qSsaOTQt?=
 =?us-ascii?Q?uuHeE0bWJs2adDlvu7ID+kUIgiaE2bHp65A81AAmeFTeQw7LKGIscIfhkoX2?=
 =?us-ascii?Q?sEA1ek7AmHBDCP4GVmws6Jx1ckdQrGc4nOiWBcFVxiRyHmh3fCB25EisViLX?=
 =?us-ascii?Q?UPLsrKg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pElsWuRnWaI4b30eR8Rag3ozLbbaWKDwGCxGCeKx+B+J3SzTB0B8/yTMKYNI?=
 =?us-ascii?Q?ZShFfosN2r54LLAFI0ZQOQn1qrQnxqkTY/3kZg3yDEyQQcyA7ptqeV8g4hGn?=
 =?us-ascii?Q?B++xHE5zS68sz9oo1D7kLGCC3nSOA08M9HGT/+Ho/URmYt4zDyF91uSWWSwi?=
 =?us-ascii?Q?Uye66NB+hgBNF94mqzkyhUGR5A6+z/dbnzxGkqK9qo1shtoKIs6nnp59TvN9?=
 =?us-ascii?Q?4t6Prnp4mv6c8LzKJaDO4W8YgbRMDF/ujs+vhTMHuXCt4k/dslWtFCUBu2xV?=
 =?us-ascii?Q?It6SHt9d9RUk7g0/8RZJGwrmsnLKDANFFZXSxwQWEKgxtAVoAAfAI0lrcTkE?=
 =?us-ascii?Q?wpGvG9qCL9zsjQhP/osHOGX1bFTjuSofIa97AUB7WyQbn8AgU1cVJmrjT32y?=
 =?us-ascii?Q?5tdA83gU7l2nKfvPXc5G1z8szQ/htY5JM7z8YCvE/NQaVbNjECRmo3LN/edF?=
 =?us-ascii?Q?KI3ffKYZsNyYmGnQUrnMuncXbym1nsED2dkNFoexy6DvumcokBUU0pO3Byl7?=
 =?us-ascii?Q?bDYbDtnmAxT7WjKXdnMfMM60DbvA2FjtxVR+qvWz4bkIB9ggEkn/wVERIa+9?=
 =?us-ascii?Q?m6vPSiCCTJSboMEq2QKfRxD6msI9HcV+yQ5omkz3Hqcx5Ay/HtCkR2rZR7sk?=
 =?us-ascii?Q?044Pl+j43ipvvtjKY/WIsso7l9T9hxUoREg19Kit8s9lcf4+HLjmIBwBoclT?=
 =?us-ascii?Q?TBL0DK5/w+7VqdM0O6fut86pqJWzJ9ozMb1mx7lgGslvJvryTTCWedoiwLHh?=
 =?us-ascii?Q?4FZcGDTZBIK/U6MuJrWlrgHwRA3IVKLf0YpQCV+5J1kOmVRebo5Mc/J4mIka?=
 =?us-ascii?Q?Qd70zncv3J2wqV2ncRIGCv/uPVp3GgopgCoHSDi8FcEVCAntu1EThMOHr//D?=
 =?us-ascii?Q?cS3d9k21fBKYDqTwyjcRKEL5U5W8qog7Wcp0cEH7/wXyW5qLrfeGLh4EoHvU?=
 =?us-ascii?Q?o46K3erOmQLkcxY3XDfOctXdJneHW4tsPIlMvNYGnhqXPxz2yndAR/kb9qCH?=
 =?us-ascii?Q?V/M4n134VAG9u765fAAbG5+oY4ZKjzDGhEb5P90BOUQN3enudd7tH+ufLOz0?=
 =?us-ascii?Q?mNM4Sgkmmz6fzSUU/SMGLV9Ko9ofD/blX5oXDan1qtCxymlKiJ0HmHpzfG9/?=
 =?us-ascii?Q?vIlYUkMSJf+3HS9ilngg7tnsUyT04lb4r45K13z1EIrXkI0ydG7ECkjThedH?=
 =?us-ascii?Q?IAlYEYQ9cgGBtRwKpyBmoepM7mt5kuCDXsVcg1IjOI76xcHZlgqnLBeuq1Sx?=
 =?us-ascii?Q?9HNWwfO9T29npzYM3sQ8AxOvvbDgxyuIYX/B5BVunxHfXQt8pV3RnKi2CImb?=
 =?us-ascii?Q?C1XaYWXXzQbHoZbG+ie2y8jkyFWqL/KXgmvtRfaBqxzSnQEU52tizHzE8eWo?=
 =?us-ascii?Q?m43iBr7+A/2x8+8blEcXx7czPGEunY0Z55E04aqgFygosLo53Q8WHwl7POZG?=
 =?us-ascii?Q?VT9OwHCP3IZ6DzLG7jjp9ziQszgcG2KCeZRadXhWTDwRo7AEdhGpeWhffXem?=
 =?us-ascii?Q?aI6yUAATjZQaGTU/MchPCCaoiSSXp65gdh+x/purFL0Id8SpMO6K0gGmDLx8?=
 =?us-ascii?Q?mlAFtdFJLvxdkFd+KkZF2XM+2oqnub7VXtDUbfhS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8f830d-22d5-4492-ae94-08ddc3885cb0
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 10:14:20.0984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ta+kRsl7Q2Kzhw2iJIzehU/gDeZ3NOTuOXWxGie27RKxodS3fpotXqAdAA8I09+Dn2KvZLQXm1dB+/HDoxHOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5854

On 14.07.25 16:51:40, Dave Jiang wrote:
> 
> 
> On 7/14/25 2:36 PM, Dave Jiang wrote:
> > 
> > 
> > On 7/11/25 8:15 AM, Robert Richter wrote:
> >> From Dave [1]:
> >>
> >> """
> >> It was a mistake to introduce core/acpi.c and putting ACPI dependency on
> >> cxl_core when adding the extended linear cache support.
> >> """
> >>
> >> Current implementation calls hmat_get_extended_linear_cache_size() of
> >> the ACPI subsystem. That external reference causes issue running
> >> cxl_test as there is no way to "mock" that function and ignore it when
> >> using cxl test.
> >>
> >> Instead of working around that using cxlrd ops and extensively
> >> expanding cxl_test code [1], just move HMAT calls out of the core
> >> module to cxl_acpi. Implement this by adding a @cache_size member to
> >> struct cxl_root_decoder. During initialization the cache size is
> >> determined and added to the root decoder object in cxl_acpi. Later on
> >> in cxl_core the cache_size parameter is used to setup extended linear
> >> caching.
> >>
> >> [1] https://patch.msgid.link/20250610172938.139428-1-dave.jiang@intel.com
> >>
> >> Cc: Dave Jiang <dave.jiang@intel.com>
> >> Signed-off-by: Robert Richter <rrichter@amd.com>
> > 
> > Applied to cxl/next
> > 4211a8a86304a53719931e7d19efc102eb8ede24
> 
> Actually 8d41af0d378dc0832d64b71bb0f71098c23dd1c4
> Had to add the removal of core/acpi.o entry from tools/testing/cxl/Kbuild

Right, this was missing. Thanks,

-Robert
