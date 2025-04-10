Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E8B28A40F
	for <linux-cxl@vger.kernel.org>; Thu, 10 Apr 2025 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744307858; cv=fail; b=sqHiGpclGg8W3kZ0eYUULa7FCYEMHsSsU5yRbuqsr+//KIBJ9zXFM96HOd6oNuMbdSXVjm1ZrAw6Zjkfq6m7izS7BCzU/tiPAYOedrmCgk78s9fpa2uB8ZEf7lJZU05GRXB+WQ/OVAH2laq5Dd1GXIcM0WeJxnHTSNUfxEX1cbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744307858; c=relaxed/simple;
	bh=r3/Ys80fUkWsqay0PDa9YcpXPXNzaGbh+poKgyRXaXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ECV9i9yrgaRXiuFqIyOJjXUppj7NlOeczLSMSgRPYx/KKBfgZjB2DzfPCTdERFcMh6TlvqSjan74q86nY2xuKzbk+NJ5A7NR6lmeT3t1jPlgrf+gO/+9/2DdQjS1vg2yEZX/tXoTE932v80V63IH57Jp8UgMgM2SvfRf5dvif9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OYICX338; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OYICX338"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxRhEJFsFkbIveCpluIonbP2ZxA+0t28p/dmyj4yTLmZkgE7tsJa4K2eQHFfetHeP9cSF0EAPV0nph2xBCRVbSilGGnD+7yZqee4res2mFiYHtgOz17hzVTJvK8TZAcY8+3tbEkXP67PS7lK7taNXBQB7slHTC9hcjsykr+ewZByIBQXH1FTyOjOJ6DvdALoPE5Y/eyZmJV109CMcnatj5EIr2TC2LMjcoDepu9enVv+4IqWhhaPvzeMG9ix7+SrbU0hLTu8XwT7YqiySUGPXGF/uFhxXmWURdKD/eJ/WEmP2Fm8UtBMObFD35ITveK+XiUJRJJwmiXw40ZWEnHDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TewxSrwkTgd9nFq/I9028sP6VpNc0bu5X93K4kXK80E=;
 b=CgRFtqepgL+I+aw3JartxXws5sRq+uz6WDSAMb8jggtPLAm/kYDcLBBUsmejkD971tag44/VD6fPUKbXh0JHDuriIAu1lx6ys9js+ZDDvnRTJjsnwFceZb2nj/6glo3G6l9iLAks9SU7ZOcfk8ifNY5AdpjEGsOqKcanhfsclEq7F1XOCX41O0h3TaxOFx8DGMT/8wFrn9btfRDpQ3svlH7kQe07dMEklvZ4ydOGWIPbir5kKzRcXbluef7/5VNCV7KEs6gU6Dhlp5uBQD0wSuHgH/mLuE/D8RrELIkInUvYDy6SG+2FvaHboD1kC1RzBiK7imTcodZTXXLA+R5CYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TewxSrwkTgd9nFq/I9028sP6VpNc0bu5X93K4kXK80E=;
 b=OYICX338/0PL18EUSjxcwMpUnfWp8Vl7hYFL2VYUgjVN2wxzlEmuaDJhkYKkwW9x9QX/Mk4caJWsnD0hT1xA4u6GIXrbP0udd6iGr176JenPFHFRxhXAEoLucVJKZTHG4VS8Y4Hbvzt/O6Ru6/FvQPMmfn6qMcyNE9QHIaJUmz+mGy03PJa8OJENN5jNZ7sPkLGCkeApLY/0b3b+ERg5wzwi9a1PTAumXGVywONHaPWzQFZBr8iaUvMCNQFdTGkIw4vKyvvnE9IkHgroZukg+XOL3vUZbbJNEmLkDXHnioqsGRxcJz1RP74hVi4qL1ZUAHWJ4GFWNs7WEwMy5R2CHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8143.namprd12.prod.outlook.com (2603:10b6:806:333::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.24; Thu, 10 Apr
 2025 17:57:33 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Thu, 10 Apr 2025
 17:57:33 +0000
Date: Thu, 10 Apr 2025 14:57:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [tnguy-net-queue:dev-queue 2/12]
 include/linux/build_bug.h:78:41: error: static assertion failed:
 "sizeof(__uapi_uuid_t) == sizeof(uuid_t) && __alignof__(__uapi_uuid_t) ==
 __alignof__(uuid_t)"
Message-ID: <20250410175731.GC5121@nvidia.com>
References: <202504050434.Eb4vugh5-lkp@intel.com>
 <67f72679bb038_2ce629469@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20250410115956.GQ1778492@nvidia.com>
 <67f8045059dde_71fe2949d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f8045059dde_71fe2949d@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BN8PR15CA0059.namprd15.prod.outlook.com
 (2603:10b6:408:80::36) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: d41f956c-0631-4bf0-36e8-08dd78592b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VmYIMBt0i7OfjitESMZXX3DDOviq4HdZZ2WbdZ0vrSMKn9m+O4InvVGr0U4X?=
 =?us-ascii?Q?Q5efXAbjITr+uViyKIO1iG0YGp31va8+dt658NZKkEOPYPVONFY1MyLQOxuT?=
 =?us-ascii?Q?+UACbyRpFjM9eIRS7lSNWx7s5+g5LzrdLdI75gIUgemdSFG+qfXGgnGDHm3C?=
 =?us-ascii?Q?g6GHw4WAByCqbo/DIZN7fBd9UxKm1FLwWFWOp9vFVDCtW3JBd9FHPlB6YrXd?=
 =?us-ascii?Q?anNXwnzNo3bOlK5hHShJChhGATnbby7czNK+//6vI7xHEc2hjh0QxfKGAeIn?=
 =?us-ascii?Q?jAOltcv28afO7Tycp344iwWaPZzQ7t/mNYuthHhbra1d+Fzg+1W8fWJ6k8Km?=
 =?us-ascii?Q?hPQIW0k+oQMGuVUjehFDzGSeEdE7Bblt88TnKDbwERy4vmIlA78efYhNzLuz?=
 =?us-ascii?Q?OSdYZVr55KyllgZmAMSWiDy5uj1u7JiYJGYWw/KaYrgdcEvkBQPvPTvWU+8K?=
 =?us-ascii?Q?H+cG5s+I0HRPVrk2vHgg3FW5iU6lO15ZFeV3YcVXXE2D5mUFhAgEC+WOHYs0?=
 =?us-ascii?Q?AkzCvaW/kE8pKRwPT2Xamfe33IugPCG7E1xjkg1BDKNuDBSNfhbghxHK5Y9c?=
 =?us-ascii?Q?yBDzUU1gSjTaMB72GlovgsqkM+L6OqfXbuJOKvrHWFBp6o5DG1erty8pylCt?=
 =?us-ascii?Q?JKWyCLWddCQaTIeejxjFHtRuK6yUdy9prJMdfEE/JpsOnlznXnrAhEVYIfc+?=
 =?us-ascii?Q?yvvrmPA2bjyEjA99F63O3nWRc2HeT5DFnKG56dmiaC+De8fxNoQkRHnPRbsI?=
 =?us-ascii?Q?9nXtXwGIjNBq6kAInM64s4GCW3smtd81JkJXgzZ0lHqfIVWU1lztoQyTXx6m?=
 =?us-ascii?Q?iObnutZOZbPDS4+t6tG8ebZTWwkEGrnFr4S53F/piyCe63BdnXEyA7m8H0bb?=
 =?us-ascii?Q?1qn0nkm01ox/rKBaFtdKHDSTxi6sUyJ3lAKWHw31KLs3u26kEX0GTTLLf0nP?=
 =?us-ascii?Q?noSaTVpH/b+xehk8ZpZJsdenvBW3p2Noi3TOjORIeWhcXGvyS/4EtnFVUTHl?=
 =?us-ascii?Q?1TM9cSjGX7Byomi5FZYgcEIORyFW3+SJ6ThJBAQIJ58QPDHxgbalXi6lpxFP?=
 =?us-ascii?Q?WxKVD9X97HqRh701MBRc0Er3L++2MSwC6ZQyDmHgSjunb4dHaOdG+Thorse6?=
 =?us-ascii?Q?PWWMukLkol5+NSZfHrNnxpktdczCW2Fa49q09zyYSB5ygiww1DZS4ekvmY3B?=
 =?us-ascii?Q?RQfjH1pa6yP/qZcQKjYU/WgJI2YONgxB6/BBNX+lCZKS2r7ColjlkQQx18Gh?=
 =?us-ascii?Q?EU/Pc5+2QvAw/FcSESOul3NkxFsVW0991y8uF6vPVQWI8pTQ1726/+9Urmzp?=
 =?us-ascii?Q?2jBwoT2U4EvWmOeLdjC+Uqur5vK/0b+odMVfQP3yw2PTnZIdY3XXfnbZjRwa?=
 =?us-ascii?Q?NP2IR+I/x77eX5hQYRWkWe2kQRTD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h+uEQZdvnTX7FoNnzpNaU+sZR469uv+RumGDzGK+CDgtMQhouq6NjUAd/k1q?=
 =?us-ascii?Q?eDxqIvgdrnJLqA4UoqAj84YIJcSkxAdqbe4Rtpgsu7F8Xiv+UvJhHJ4SU2nF?=
 =?us-ascii?Q?ExaNIkn2OzG59EiSEsOJYcPPt8wWmzpcMpqBWRrapL3KKGvT66ptFBjrePFP?=
 =?us-ascii?Q?HqHZge4+7AMO+fVsiMcJieeQRM3jkIP8aZb4liv7ze+vT9OsyyUssG/HulnO?=
 =?us-ascii?Q?DSG+8wjIIRhFIUD91Y/XM297kbDmbGAAlqSm7xYqwLhXa3YBTK4ppflAI8Rb?=
 =?us-ascii?Q?CIXlpR3/pIQas9ZDnId9yy+UXsLStsxlV5CKGkKwtTvUu/4ghvalXun4A03a?=
 =?us-ascii?Q?3BLXELnCWUZupIo6xFxQTVXwYqqGGStZ5qCAcXCqEYXAsGcFDzD+Ct8kaFh/?=
 =?us-ascii?Q?fVr7yGV9EUK2zgRNyKrAOeIkQd325awshDoUhAFoLZ8fzTdzHJCdDK2hBR3M?=
 =?us-ascii?Q?ihDXUjLlHi7GmkXosKc6OsWIBHnMTon3L3hlM06yhtbf8m4Ijkg22z8RD6zF?=
 =?us-ascii?Q?dBRSwNeGmxFTNEKijjGSTEAEHRxVnt6Nqm2yY4CnQqLA0/TYlXKRHHStpHzr?=
 =?us-ascii?Q?viiuLGK4j90sb5X6yOvDj1rcis+sHAwEHxZDbpUWg3fuARxC1lkonC5A0C9y?=
 =?us-ascii?Q?T819iJ3+Fx1cbF5grKAxLg8WNYA3K5wcW/Y1gsy756LAeBcruIGu/imYkbwf?=
 =?us-ascii?Q?GqSBBPnt5Vr8n0zSP1iZL7JE/8B7Ca5xbk1oxGo8ieVHKxEmWMVsqJtDvszz?=
 =?us-ascii?Q?O812bdy5TEy34+EBb5A8/H8QPh8k4pI/E3d2oEORhoADIYDA+Cl257EEYkhh?=
 =?us-ascii?Q?40+MpSihtta0vmrrpaLJmRxBL0mzX6m5Flmb/yomtgBuIuwBu1quZBbhYapA?=
 =?us-ascii?Q?DeKrn6tUeN+1EQt7m6JYXeDToQmOtiNqN2oKfOsHiRrOwja/LCznboXGHSYR?=
 =?us-ascii?Q?n29MUUUSFFo+ULNzpfVDoPDICuFEq9XbE5MmP4nh2SALpV/6miU7xrLxe+HO?=
 =?us-ascii?Q?CkGhw842VklxVBMpuNeI99BMSnFH/ZLoLvll7zTDj8ZwXRjV5uMM/og/l7TI?=
 =?us-ascii?Q?bG25BMizOAZ4eR0xLLkbmLFosO1Cy6xi6erzfvoMabhGVViW7P7cq7XLZRim?=
 =?us-ascii?Q?QuEOi9FlPV/KKo5DhtFKqQLCAc+EweX6giQ+JLS9g+TKUKCBFK2Gz9yyWYje?=
 =?us-ascii?Q?W94zWgw446sE8uJJMKTRDU8b+MLWkuaxvMoWrNATPt1VUwl23UVKpUd7Gkfp?=
 =?us-ascii?Q?+AY9EEqRSjhLRf6piIDjRg7H3S4h3NEV6EAj4dMiq9h6Yn44kkPyMwZrZWZv?=
 =?us-ascii?Q?PZM+DSdYys+qZaQsT1hDFCfaNkU4slZgAraNqPT4MZfAGiWe/pz7UakHGy46?=
 =?us-ascii?Q?NHqMkDUvvjc8WcS2BnVAq4AxHdqaWO4aBp0u61uGFEIIsY/acd7gbaedK9Wg?=
 =?us-ascii?Q?vqM1KoeQixrP6C0sNd0gDwHxxqV0NCv8RURbXIJA1ULuxfqiZa+n4JYIfOeU?=
 =?us-ascii?Q?5nRMXa7FSd2UmnWjonXpmp/gfK+BPgHyNydhsA7lOdfmGzbpVz6KlsmXsJqk?=
 =?us-ascii?Q?X6imGTAs1ylKPOi1XLYBtKPSa0dDn8x1VYxmn4SD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41f956c-0631-4bf0-36e8-08dd78592b29
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 17:57:33.0353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EczpjyxPTQYQrodmD5jCmkewar+CChbGv5X8DXMyRO7Rwl1xGuj4YM01aVqEXqBD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8143

On Thu, Apr 10, 2025 at 10:48:00AM -0700, Dan Williams wrote:
> Jason Gunthorpe wrote:
> > On Wed, Apr 09, 2025 at 07:01:29PM -0700, Dan Williams wrote:
> > 
> > > diff --git a/include/uapi/cxl/features.h b/include/uapi/cxl/features.h
> > > index dd8874860cec..06a1ae3f3fd0 100644
> > > --- a/include/uapi/cxl/features.h
> > > +++ b/include/uapi/cxl/features.h
> > > @@ -14,7 +14,8 @@ typedef unsigned char __uapi_uuid_t[16];
> > >  #ifdef __KERNEL__
> > >  #include <linux/uuid.h>
> > >  static_assert(sizeof(__uapi_uuid_t) == sizeof(uuid_t) &&
> > > -	      __alignof__(__uapi_uuid_t) == __alignof__(uuid_t));
> > > +	      __alignof__(struct { __uapi_uuid_t uuid; }) ==
> > > +		      __alignof__(struct { uuid_t uuid; }));
> > 
> > Really? I'm surprised that the struct wrapper increases the
> > alignment..
> 
> I was also surprised that gcc has different rules for this alignment
> across compilers. Empirically this change solves the assertion, but I
> admit this was just the result of tinkering until the error goes away.

Hurm.

So the reason to have the align check is to ensure that when it is
embedded in the structs it doesn't change the layout of the struct.

The only use is this:

struct cxl_feat_entry {
        uuid_t uuid;
        __le16 id;

Which is fine, but if instead it was:

struct cxl_feat_entry {
        __le16 id;
        uuid_t uuid;

Then you have a problem as the align by 1 version will have no
padding while the align by 4 will have 2 bytes padding.

Wrapping in a struct for the static_assert does not prevent the above
issue..

So maybe the answer is to drop the alignof check entirely and add a
comment explaining that uuid must only be placed on 4 byte aligned
offsets and all structs must have explicit padding.

Jason
