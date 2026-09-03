Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6398F26AC5;
	Thu,  3 Sep 2026 00:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788396752; cv=fail; b=f1x736UmSIumLjZXTK+4ICFtE2NyzKFlB+dwn128REoXQDZ+P5wG3h0O8Exq7EdAsBetdsvgtl3nJ+vMHLT7LvBMsUwEhOxzLj7blslMsB22v7hRj11gPgFPe0eVCdRFavJP2LOusYHY1j/dlx1QNZHG7t4x4pZwQDof6MSe6YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788396752; c=relaxed/simple;
	bh=UBRtgkKF+0vrCdXtc6M8sky6v2VswOPrffO3prUNY/s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j1uOogHWUw1KVYEluKchwM143mi3i9vMnOH66tXZeUaKZmhA4dP6ybkZyXRXIwVEhIY/9pw15dB9K+WekL9PFFSAXYvIedI2wxiIqpBRw9Ntr9rQTpc010kPzEcDpr/l9Noxrj+PkjBmp+y1E3NTHiYjTSzlAeb7stkULtCK8+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M94ysCGa; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M94ysCGa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788396751; x=1819932751;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UBRtgkKF+0vrCdXtc6M8sky6v2VswOPrffO3prUNY/s=;
  b=M94ysCGahhzfQB0X+hpnMAtbj4Pha0kmk3mr7SdkDPHo4X3ehU/8EIIe
   Ys5spzok7gkog8PgbhxWQcc8Oxm+8pwY4xTnaoW+NqxDaCtjZ0sutqoaQ
   8gZfW+zRRUl2TUr1pwnfIL9kvYwYyZsJvljHaXGJE1/yZCcMinZjF9Tvo
   TZLQlDRFlJbTDqd+PToHDHGDtqIKfBDT6XsZ06mkbNs4PvFmMdjvELrwE
   I8iVGWJZj27kmip1dB1tRreA5TZbgyXpgjnpOJHQ3KhnP8VjwNXNPq+Kn
   bobwnX/kAVnZ/eYCRw3URsFo2yImf3+vO7FbSnSfr2KJ0hbmyaYWFf1oD
   w==;
X-CSE-ConnectionGUID: ixkSfhtgSM6XuwxYTzF9mA==
X-CSE-MsgGUID: ejOcYJ38Sku5loMiA8QX0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="89079061"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="89079061"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 17:52:30 -0700
X-CSE-ConnectionGUID: L8s5vSTgTJumJ6CMVp3UiA==
X-CSE-MsgGUID: 5WQV0zKoQaqF3R4otFNFEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="266319043"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 17:52:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 17:52:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 17:52:28 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 17:52:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZwsQ80JWcok+aQ46tecJrXRM/rGG0/zm4emJZHHozHPXv9dhWBmF/ev9NdVxbNjtq1fCnkUxNn3j3A366RuLhw+5cI2/hcknajAuORqhmnyr2YBywDGjia+3Oa9BTTxyHeA6Xio5gHVKqfFTK2H89OZOOxUEqMhbqaxRgs+m8aVW+jmg6mBSbSVUu5yrdEF5hMh2gZftopDFhmlFCTZWlWQ56DUzU0sbZXalaHtgnfrdbhsGfpgViHfvH8a7Xl5TZTynbVRyviuj55ll63nAGr0SMMb3aXVTpAe2ZPJ/gUPT/36xouKTMqzFYLvyqk1lZhgRWwfJCIl4q0GBAGmLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSrAqT9jdKXUz2+Se0oNm3L0w+3Ws7lIP22dC3ndj1U=;
 b=MeD3T3L2DY3Nwn2VvqHLMKt1dSNONXtuaYM076lxviusvs/h4hPTyvBC+bWLGrOEkFMFTz9JMzTIs6jU45NCzqySG0Zr1JXAgSsFP0SRIe2eL3fDNYGSs2uekAtvq2lfvBRB/T6eJNIbQLqenDt6dxWwhtiFTkNNBW3F+jOLWXdhDMFPJf5yCOgsPdPDnQfjYCA5og5Q89LGlZmDZBQnKNIZwyYWxr2mBShMr9EADXf26Fzde2+jxCIACYotR8aS1xfI09yVvIK+fb8WoC6GPETVh9J4xamVB1/AnIqvkS8MdGik6klRmjZkGVRBPErsu6NpV24ZpUszYzEy0Z61sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH8PR11MB9723.namprd11.prod.outlook.com (2603:10b6:510:3a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 00:52:25 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 00:52:24 +0000
Date: Wed, 2 Sep 2026 17:52:21 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <icheng@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Add Richard Cheng to CXL subsystem as a
 Reviewer
Message-ID: <apjExfCleHzP_JXx@aschofie-mobl2.lan>
References: <20260902235348.3563444-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260902235348.3563444-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::27) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH8PR11MB9723:EE_
X-MS-Office365-Filtering-Correlation-Id: 165b5bbf-aa28-4cf0-1664-08df09559e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: o9jguWxuXhSQm/z2DQmq451VO0Tx+odvLorodXMJNLSQyewNCMCdvO4phS6ljKODHyuNMsvH4ZTzV9+/zFg1fyeIU43SyKg3trQdQhwDUYyCXbuuslWksdbFr/B1SXMJaJyW4z/mMA+6E9a2DodczJw66l/46QxqekSPuslA1IwLFeohWqnhUVpfJTG/TLt+AgyFPSkisGHAg+C9YjPj1zHLJRvjbvQh5BA7OZW72nDtHjwnxM4xzuaLId3X0Idrt2HSmFup5G63ZUQqqbnENXJBrsnNWsx3ZaulvVNZT70r4h6Ak+iausP9h3xw0EsDs55wa5CnyJ/1yuNptJ3eHMnPds9ntfuOrVy5HKtXNSaKRB4E0rGKJBXds5kuMVjURnc8AfY4NxgHv951znYNkBtvF5qmuC1/nHnYtdKEW95nEdCgQ9cE7qK9yepINuzJJ/mSYsHP3xXO/iHnofFX/HG1tkVp0q+fBOs5h7eDmC9ifrVl3FTUF4cGdSmIpQzTKaMtwZFWl0rfd2LlCq6iI/NqirZ40vMEh+PfzRbMBalq8TMgOLQubldkcEBHud1B/OAyzzejpNQmTA6PTBjYa081RS6oettiW4MM8i6rr3QhpfVwOfpRBoAoQ1J7DLEV6ViUaYkHHDrW0w41Uyrnbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o6TBzw1eZqSRlm9QveR/oUGqA6rSFji8ZnhqtUVGiefFPHeD8rw6NOfLhqfr?=
 =?us-ascii?Q?B0Izczd5HT+e+mbfrt2XeDm9auIuP/niVsc0sFGDbDcLNs1uiosekfnHp/Me?=
 =?us-ascii?Q?fEeb8ZxnrjI6ouSKTlTHDLtpScQj2Vvgsn5lY6xGR0gepnxIu5gJHqQotVp8?=
 =?us-ascii?Q?FtUzuj9muulnTAkenyIkZZnp3iaPwWxeY9BnOwryDSVdpx9SUgP67EwP20Hd?=
 =?us-ascii?Q?U4JeH6PZOjI2LeDWEErU7wS9yZXPp3wI6sm2578ovvO/3qdDzV3OKVSUvKu9?=
 =?us-ascii?Q?nIUt7Qzu2Vn6LH6LnyXPRALdMDa/mxOk13F2xGn5DagIOAT3r/jwsPxIymo0?=
 =?us-ascii?Q?C4AbOMyi1TBOAszomzYQvqd3IdFwV1KyCV6TUUF8FtzWvwgFhlTqnhebaZO+?=
 =?us-ascii?Q?Ockei4qccI9TYEOGTmfuQfCoWRk9DUNf6jl/YnG0in1+0+1HIkwh2dZv0oaA?=
 =?us-ascii?Q?pemc+/dRtBu3Ivj9gT91sTCc4iRilkL64/3wwKCb1BpxNhs6tVaYzft7RG2A?=
 =?us-ascii?Q?TsqkRdD6h1PWhS3SXks6ablaaU//KQdkrsC8GEtOGITSnManGceQpnX29jPv?=
 =?us-ascii?Q?csvjrLXq7JXZ/SsdzrEBk9rL82j0n1ddI36JUirmuXD+yLXEC2UG3w+QZOYt?=
 =?us-ascii?Q?0YU4aeLxrodTab5/z1t0Wi1lyqP4SfkuMZIfthTO1S/9Vb/bBQKJ6H6IWrb4?=
 =?us-ascii?Q?PUrUyAr+8XeNzOY7eEr1b3Z4ixbPZXh0o2ZIrunlmuCJx7FGgTvWQxmFYRsC?=
 =?us-ascii?Q?GVFdsO85jKghEQeTeQIaHJ7kDERgp7ItgtE1Fb7jIvCZUXDl/wZWFdCRFACk?=
 =?us-ascii?Q?/sTX9T4P/3F+E493UNiMTjCKcUCrqWiSzKuuPNL5oExHo5aZtTCn6Gl9DFhR?=
 =?us-ascii?Q?yeOmB+wScwvoyfWlhqz2VI9jJVvuLqjdHASjUlldSp/RrYYBhr5J1Oi9YmHI?=
 =?us-ascii?Q?N6ScJ207CfFuI8XLfx0eL4CxR/SxeHUTY2gfDfCRypJ8hhT3KJUXvfUHjQJ7?=
 =?us-ascii?Q?mOj+R0MEn/fQ0qzSCC3pAH150sehqJ0a+lPRzcaM9Xq69QhTInRV2XmFnOA4?=
 =?us-ascii?Q?i31XXXL+hpd05ylmuavN0LojYONjm156vLl4CaMffoiIg2g/NhLiBV83ftHJ?=
 =?us-ascii?Q?S7Pn3PR2VDhv6ZtEw+wUDjmu2p5Gzrxx0XRFZ7ik1jFVVU0o5rDnorET8+0b?=
 =?us-ascii?Q?o6t76ktTsUv7iO4cgXktJ9hYAx4QPvczaAsEPuCwFWX24ucRbXvuO9JdnqDe?=
 =?us-ascii?Q?6gk6cSStyta5tGvYhzMEgZx16Y5N4MKx8IPjlZvjWDdDTGyp8DX6j0Uak9TQ?=
 =?us-ascii?Q?K6t3ihfO2bOZ33EkrIhKLo6AUpZn+e4FmKMJGnmV/k7N3ANVVo9tadkmiMCo?=
 =?us-ascii?Q?T9nIH701iLlwmHbdiEtKjelof6lGZYy7sWQy6KFtVWWmIhD6ox84wmN1gBvL?=
 =?us-ascii?Q?+2d6RpfSW/BY6/lipq3FU9CCQl7hu6x8JKYhYn2QyN0IPJvUEapxD85aIFIX?=
 =?us-ascii?Q?SnFEhIJKZUVN9m0Ln+ddM8QFHT0SMxjCZvOv6HrWHbR+4N9kq2uu9IcKldXk?=
 =?us-ascii?Q?Ks0q/fvHYx3DF7w99zs+kT2Af64qCMMolvPEOXF8775RdQ0hWLocjy0GZ/js?=
 =?us-ascii?Q?CnO5dySVhDUphN7CMBLlI6bU1ReWsPz/yqAlMevTsJZXs8QmnYzfJnAorJTz?=
 =?us-ascii?Q?bVyIf/gtffg8tzqcWW24tstbajldxq3PSvqd/H4hBBS4HM139IXuWGS+94DE?=
 =?us-ascii?Q?zQeEgqyTzGNmQFy26tvg69MtL/72ntg=3D?=
X-Exchange-RoutingPolicyChecked: ToOKIByuNdK0m6ebEEbc5eYSeiR9M2wag+6gkWnKiEZgEXKWSTp+CRYxawgx7wYA5J0VX0e9abjswEBmznpD4Rcy2EvlojMl5Dqm82Ozx4S93I7nmMeyprpWukVQ380JLykCepULApC3HU1rUiBzkmLzIhMxnStef47/8s9c86JWjiws4QoCHeZe1ZQ2zsFPjpu+4xHNvhqCG+9+n2AirS2KCeXAo1ZK+CNvM99PE9l9hgQK15NUp8jjR4cqlMN3675jNUtMsdKs0eryf5nfXR7GfzaBtt5UrMgvwMz7z9sxJvWzcPska6h7fIhzTfpyvubmue7/T6SzdKCVhYWySQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 165b5bbf-aa28-4cf0-1664-08df09559e82
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 00:52:24.8145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yo1undz7gi80BA7nI075iCBbOLsjQz0qwfYIFxgYKAFv2YDvkOzuSEtrDF8HEBSRLhU9z/N4T2jVTTIIPPp0PfoGXweRGG4IE6FRrxQJ/Fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9723
X-OriginatorOrg: intel.com

On Wed, Sep 02, 2026 at 04:53:48PM -0700, Dave Jiang wrote:
> Add Richard as a reviewer for CXL subsystem.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Richard Cheng <icheng@nvidia.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Yay!

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

