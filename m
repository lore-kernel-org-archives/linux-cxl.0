Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012010.outbound.protection.outlook.com [40.107.200.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D60D344030
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570329; cv=fail; b=AwjW+zE+L5xAZNAgbB6VVTRlqQWJhHRNVNpQF/pkXNOCpohRBG1zEldEH3gFtJxEi43Y2x/cLV2TdlQnsrSKVJI5H1P3SdJLaKd+KyyeCryAxybjXSMtS5rp0lTQZI8A7znikJ42AdlT+T+85T6StvvZqAaJ07M7VzDd1iYv9NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570329; c=relaxed/simple;
	bh=IY3YiXHVSqNjgnCoclr7JmB5k+xXE+Iukvre1VvKwVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SANPYoymHtOCDSVDtKttRqgmzAokGvp/mhI/eWwsThUhkuOZLxenCkt7hMTVHLlinBEntXkrzAqiYjhM2pVPbytYtNBT3JgnHHu01o5bb10VouiHNwL10VtKc684KdxOi6fHlBU/bDgwJHDSbrx+8PRrjpVpXd5fPnD0Y+2/56I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vc/Qel5w; arc=fail smtp.client-ip=40.107.200.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vc/Qel5w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYi8lUsLIzWGjzmQa6iaspF8E773Dzg6WNzXy0UCNu5LJxVo9EpiIQP5hHRfZC6oUmXIEWStf3pVnNR5VIAW14PgfXcZRdRFFX5yPXop5J1xYzE7op8VtSJp2d8o5+C4Pc9vmryYMOGv7D+3Ny1VDQES2WruZscrPoFloWGfGyoTaJGDtvUarE8n877RtsBBBJwnoyrwyXnoNJCSggAEkxfBX0GKVNmhAKQFrCGiNcNvJ8nc9i0JX5P1KtALM4G99H2X6BTSAVvXq8/qmH4rXY9cUrepi4AosYXQS633JcWBygWFHdTXKW6SAED5DZIzhQxgsU/GVToBgtXWk35nVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1wN9HdcCKV6qUEBALcb4vRpV2viBr6o5w1odvrwcnY=;
 b=G2rn8t33w2KgEoOM1+rdun+WEspUr5HMzYHQfo4gLZuJBDcBkVes8FpilXAspux1ZLiK1QHAMB1apPdPoLMoUsYSIRVdiB3BjEsAhW3jqb5gPO2BJk4Cw+O6SmsnsuRh8wF4H4qA5aDBPEhg6t/6KOnPDJnJNsvj1eRpkTEuTCpjiz5KGOOQA9lgDuhFhPD/EYtgOOvhRwfCRuDYju++cKqrel2O9V7Bppsbw5HnNaDZjy0QHGspXxudCW80cM3rGlYudHXVSIY9fes7NJ/zdUz4zMIAfkFXiMp2ShthXJ1OIY4x08aTNpBfo+MFBqsHdpHwDPELjgJpbNQhHENGlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1wN9HdcCKV6qUEBALcb4vRpV2viBr6o5w1odvrwcnY=;
 b=Vc/Qel5wm6I4Lh66nwbhFpfrJE4JiXjt2kBB88HeaWDLacn4lAf5rWCTt2bvyBYmZLAzi+Vz4bCGLjMs0n/oIJ71Mht9ey5hDEtD8TFXQXez2z3NoUr4sEzmPh5WVAZsbs+Js/c3fpMIosEp+h14uY/onH2TEL3/rlFN+5ZBCiWK/uTNCn7fgbEfV4nD8yZjuxl2nDmeAyz407jbuL2ljEmleSYW58eid1l6Y+GmEIEM+wRK74uhAVYV4khdofJyYwR0tFATVloFRpee/JPbdOERegxB2vq5mKDfXc2vPMlNrUpmQVQVyv4Fh3loaINuKRJUGKEkp6mAKubfkFTYpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 4 Jun 2026
 10:51:56 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 10:51:56 +0000
Date: Thu, 4 Jun 2026 18:51:45 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org, 
	dave@stgolabs.net, alison.schofield@intel.com, djbw@kernel.org
Subject: Re: [PATCH 0/2] cxl/pci: Fix the incorrect check of
 pci_config_read/write*() returns
Message-ID: <aiFXjmEsg1-_6EtP@MWDK4CY14F>
References: <20260603185752.4149725-1-dave.jiang@intel.com>
 <20260604111744.74cfc2bb@jic23-huawei>
 <aiFTbzlUZEr4UT6F@MWDK4CY14F>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiFTbzlUZEr4UT6F@MWDK4CY14F>
X-ClientProxiedBy: KU0P306CA0082.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:2b::11) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: e261e3e0-fba3-4749-8f21-08dec22748b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|11063799006|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tfocjsXgzq5/trz/cyKT0wdrsM6HAu74SHibMMlsQNMWq7avROpjywoO1fXWcnuAbvca8qkV8E9ZSQmrEE7vTop+kYpA1OOo08pSIWKa6NtxTJQTVjDTrFCLZThNGBeoSpcH/oKMj4wQKnU1d+/UpOukJPYYw8IFLD90BWjMhVUKGe3j4T09UUI12CZT2lKYoNSJE6W+bHVKJ3l4WBRLAlfjDPKoNr7Uoxk7Tptm8qy1ewa1uIRDZfExDbjLsXqmoU3iL42nrGLIkOYpktP+iFBvFSjGmS8yxOA1avPJQmOgu4sIfULVMXXMgNiVHxXm/y5fxCK6R84iQxI7wzjw/L2Fw4BU/tnV+7ofQVwX5DZRcy8fvVYCq8mjgCh4rpE5uCjXZLVhDd7Y7kIRUxi7WZ5kNYpWTfBfjPWYtAKGMaOvUXKVxxOfluA4IjtOb3hCvPgNvHMv3WBoegUGYjIsuuR2VUbBkyS9wnJXJulwosfioUZ2JxgS1tsSAGkJ75eujTZYn1P6Fj5FgR+ZQUVOyGgUml2nkKn5rRy5yS0QE6ADAplgbbGxbEK4ALSpbxpBus3tXBXvnk7ZDQ+nOd0cMD9MEB0tMq3ICgdTLzh7rqaC/65ULklMp9XEjyF7H5DxVHtiQON/GdiCtc0Y0SRtFpCYp82BnIDqg6CILmIM97bz7kepYq4jDcJjbaiANg0i
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c002S2t4MDhUbHVObXZMb3l6QWsyZFVSN1hRVTFLY2kreTN2eExvQjhNOU0y?=
 =?utf-8?B?VnpCNUhPbUJOZThocThSa0hueG9TNVNOV1Fyc2FpYTJvdnZCcmd6WnhpUWFG?=
 =?utf-8?B?YmNiSVVsaWlXQlFaTENIM1pQc0ljUDY0RTN2WmJNbmJPK2lhZCtHOTUrUmp4?=
 =?utf-8?B?UEdHNWw4WjBGMzVNaHlhZUR5bHgzR2c2eXltekt1eUNMdUh4Y3ZzenEzSnp0?=
 =?utf-8?B?cHpxcWJlT2pZSHk2eVVMdTVRMDJUNnBCUjlnUWVBOE1OUHJpeElnVkVXNXZD?=
 =?utf-8?B?dCszMzhQTmt1Sk9HRXpCSDZ4aXFwbk5sRXI4cmhNeVI1eExuNUcxME0wbmoz?=
 =?utf-8?B?bnN1Q0tHWm5uN2FrQm4rZExRZmJ1MGx4STArcDl6cGNGRzZWK084VktQd3Z1?=
 =?utf-8?B?dFU5bEM1WDBuNkhhMW9oNnZLdm1rR25XMTlxRmIzTmtDMy9Oc3Q3QlpRNkky?=
 =?utf-8?B?a2RjVlhzUG1qeUtiZ2xUVERCUjJIcC9SZVpzaExVYzI1eGthRGh6MUlqZ3Za?=
 =?utf-8?B?K29uNGdTQUdoR0p3b0Npc29tNUdwcHk3RzVrT21aSGNUeFV2ZFVHRFJHZ29U?=
 =?utf-8?B?YVcwUnlSZm5FOWpEVnJZVU9NTnY5NlhkYzI2eHNzRGlBek5XUm1RVWxwRzJQ?=
 =?utf-8?B?SHpaTG0zYWY1OFRHVE8rdlNyVmZpQVFtVkZXNFlHU3V5OVJpTXZGWkVjOVNG?=
 =?utf-8?B?ZE9yQnEvd2l4enJtQ0Y4K2dpQzhWa3Fjcy9DOHNjdGdZM2NVUFU5V2VPc3Q4?=
 =?utf-8?B?OW1oS2pQVEIrMEpUSzVwbFkvdE1XcnA0QkZ0UDkvY0pVV1VsY1VrNHdSZTQx?=
 =?utf-8?B?RURpVGVNUkhDc0hpZXRWRFhxVWloRnBzK3FRR3hDZ29idjNoTjVkNVVJWisz?=
 =?utf-8?B?L2h3RlpvZjBKL3ExVWxHbUhSbC9tZFpNNjNrT3FzdHRRUGMzalBsMGJYcmFF?=
 =?utf-8?B?OHVHOHpRRjlnUU9VNUtITnlqbllWRmJZVE1EWC9NR082NXJaR1pmQkxxY0RD?=
 =?utf-8?B?cVJFV1V1bWx1NlJDUkR0UnF2QU1JY0s2UDBRWVd4N25oSjVHd3lmb3dTWFV5?=
 =?utf-8?B?cDBkbkNMdkNqaThNeThLLzJQTFowa2g2aFRSY0I1VHRac3lxVzhqVGtmWHN0?=
 =?utf-8?B?bUJWY0Nkc0dSM0VhRklhWmlTS2RYNXgyYTMxNEVmK0tGQXRvcmdzYUhCSW43?=
 =?utf-8?B?aUJFUVVUcGhMUEUyRXFkVUFpQ21RYzdpQXgzRkdNaWxHRnZUWmwwQ2VNd3ZQ?=
 =?utf-8?B?bGYwenRVVzNHQVJzU1V4TjZjSW5HV25hN3dPWFdEL3dHZ1pRSm1iU3ZkNCt3?=
 =?utf-8?B?YzlZN3JaWHAvSmY0VWdLTFZROG1HZk9TdStGZEJHOHllMDJQK1p1NW5uSmFu?=
 =?utf-8?B?UTZQdjZxNzBERUpkRXZ5ejdGcTd3R2Y2aldqbWVKWW1HTG16Q2xDZC9KbG9t?=
 =?utf-8?B?c3d5OFpkRWhiNVY0NHNwQzNPQVhBRy9IeHpGN3V2VncyempQL3FOaGJmdU1I?=
 =?utf-8?B?YjVJc0UxY1Y3SzI5a1cxakxKVmJIZUgrbEk4U0VYbXJXS3FLSkU5b3ZyUGRk?=
 =?utf-8?B?dXpqMm1sUHdBaVJRKzMyQkd3aVoyU2lNdTJXb1cyVE05OVVCcDQwZ0FMQ3Qx?=
 =?utf-8?B?TzlUZG01bmdiN0djcDVLZlhFZHBIRkJXcWJpNEYyc1p3NDlLRmlDTDRGY1kv?=
 =?utf-8?B?VHBmR0pjU2FNdnpBV045ZnA2NW5rTlpzcWF2VDB1cnhSNW5OMnkwWHNGVHd2?=
 =?utf-8?B?anRpV1BhN2FFSzYwLzV6ZzZNaTRWcXVIazg3RmxlMkRIVERjcFZGMzhYRi9K?=
 =?utf-8?B?S3cxQktrVnY1cjJMVVJ6UnYvdVVlWTdDaVRvcUg3Y01nWWVnY3BaZGRxWjIx?=
 =?utf-8?B?cW05aFNyKy9XcjFnM0ZLazBYUWF5US9mdXBwU0pTS0NwUzJWQmpIVTEyc1Aw?=
 =?utf-8?B?aFA2bnlZNVRjV3dmSndHS2s5NzZmbmV2RVNXQ3BsMEJTRGlCRXRINGx1U3JC?=
 =?utf-8?B?MUJrSzJTR20yZGVRUTlxc0l2Z3BFQXlFb1AwdlpYZ2N6SW5SVGhFejM0eWZI?=
 =?utf-8?B?ZnVjWTlhSnRDYzcwQ21Ed29abDlvVmc4VFRkQlcvNTBTaEgrSHY2ai9EVnAy?=
 =?utf-8?B?WjN3L3hzZzdQZWZOd2h4OFRTcHRZbm5FZWo2c0RpbzJ5NDNqODlaTmVIU01j?=
 =?utf-8?B?dkpUZmpvQUYvSGxUUGVEQjBHSnR2N1l4bHJQMTB0WndGdzU4UEhwNjl3ajFB?=
 =?utf-8?B?SUgzaGJkVkpwampSN2JzNVNZMm1TbFkwM0dSOEZvOVNpL0F4UUhNWjBOVEpv?=
 =?utf-8?B?cXhtWUFkMUhBVXBWZENCRWQrM1h0dXFkWU9YRHBoWUhCZTNFQkRmUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e261e3e0-fba3-4749-8f21-08dec22748b4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 10:51:55.9668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOq2aqm8gRUAb/YBTrmYnZOGsZSHekU7Hb5OZgariROVn1fZOGwIqJI0LuT6Rs/K1NWAWwgnFPRE5C0EyAXOwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771

On Thu, Jun 04, 2026 at 06:30:48PM +0800, Richard Cheng wrote:
> On Thu, Jun 04, 2026 at 11:17:44AM +0800, Jonathan Cameron wrote:
> > On Wed,  3 Jun 2026 11:57:50 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> > 
> > > The patches are inspired by comments from Richard Cheng WRT pci config
> > > accessors return PCIBIOS errors that are positive integers rather than
> > > negative errnos. I went and audited the cxl PCI code and found a few
> > > locations that need to be fixed. There are other locations that may
> > > trigger issues, but at this point we'll fix them as they happen.
> 
> Hi Dave,
> 
> Thanks for this, sorry I miss the email somehow
> I'll look into details later, seems reasonable to me from
> a glimpse.
> 
> Best regards,
> Richard Cheng.
> 
> > > 
> > Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> >


The series looks good to me. There is still some minor cleanup left — 
for example, cxl_dvsec_mem_range_active() still has the same problem.
I plan to send follow-up patches for the remaining sites unless you
prefer to fold them into this series.
Let me know what you think.

Reviewed-by: Richard Cheng <icheng@nvidia.com>
 
> > > 
> > > Dave Jiang (2):
> > >   cxl/pci: Fix the incorrect check of pci_read_config_word() return
> > >   cxl/pci: Convert PCIBIOS errors to errno on DVSEC config accesses
> > > 
> > >  drivers/cxl/core/pci.c | 22 +++++++++++-----------
> > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > > 
> > > 
> > > base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
> > 
> > 
> 
