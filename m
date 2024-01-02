Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2E717981
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jan 2024 23:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLMEFvh5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704238983; x=1735774983;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QHMiQTHAZNTCqX7JRNcmos+KnvRcmupLVmn0z0I8GVU=;
  b=JLMEFvh5jIpdyQCdPurzNIJWPOgdxj50DS3J2vTQWZHwFRyiXkenAQqH
   YfEhS8SyDtf1KkXo7R86knSMf+RIiOGuBBst47W9dCvHUS7qyk2ULPHXp
   N4kP3tH4XSDrljDUiRj27VCsnDw4s89j0U5+eAV5iNPycgdoePvIOq/6E
   fMsAEXuRKY+a3VX3EW8WQQx0bkcPye6r0y44bAWZS4zuuIYQHBzKqx2ZL
   5sE3tokeVIN/qeevnJMIIOTteN1G26ioNG762UVtuo22xEGiI2S9dEH/d
   M2r2fJD8xrtLF78ApU9KYTnhcigFuaVRdOnC32rMzWGZMJNgPDlaJObWJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="4280759"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="4280759"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 15:43:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="21914768"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2024 15:43:02 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 15:43:01 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 15:43:01 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 15:43:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQqzAUwxDKNbxU/t6fMuWPrSRnTypRXubarlYscdW0tGyZXyUW5u2/fmAkuwooJyWJi8ydgCnVb9Dhok6BcIWUAH3a0YsevDshA2gn1klfNDEB15+ItmfLl16tUSd44dLXnrvpUTzb3QTH7AGTTBTEN5At1EYa1WlFYWGxq6I1ZmjzrClQhFZwkR9gptGh1PeL1C0sLCqf4xYBYNrlVXWzaAligHXB/EqoG8MXltGTt8if6/fUlG12tGkWcyklYcHvD50MMhhS2s76T4Z+HqjCGY9KKZr8DaP1ulLUEfKuselcuS66j7Vf8+p6fpuqxs0wI2CIpCm5rtj81+zbboGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvcYoG434mJOR/btDabYweECtLvaCr7Qaz/okLjYkpc=;
 b=c5Xgry8/7HrydYpC0uhtiw6Kcw077wHMa7MRQk7895preI7o0EbJxAV+5hTVQcpy5bVGAL/10OWDNbYOgOoh4SSbOcU4n7eTPSOwHjaaLj+JMoA67HqdtCWV3XTBdii7QfRaTnKq0UkMNC3M2yk5XwVixllwJjwzZh28T57Ov8xJurriQIt+OD6MVioXc5TD2dk5tRO8t8aWX2hdP/nt6VooS7o+iQd2cyxtJOXUF4qwrbaGDQpCLsDRcknmNflQcpxvVnUhZWT+TofqZdmUi+4cQazx1439wGgKvyy9dSc5F24lI45Np41RTu57bxU1HvH2mqAjzgj8KWf00yqJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Tue, 2 Jan
 2024 23:42:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 23:42:53 +0000
Date: Tue, 2 Jan 2024 15:42:50 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Andy
 Lutomirski" <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Dan
 Williams" <dan.j.williams@intel.com>, Mike Rapoport <rppt@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>
CC: Alison Schofield <alison.schofield@intel.com>, <x86@kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: RE: [PATCH] x86/numa: Make numa_fill_memblks() @end parameter
 exclusive
Message-ID: <65949f79ef908_8dc68294f2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240102213206.1493733-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240102213206.1493733-1-alison.schofield@intel.com>
X-ClientProxiedBy: MW4P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: d2003e4c-7054-47a9-06ab-08dc0bec89ad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0DqVVEHawpIK+CQYHM4WsC97TbkrO2nyOLWgMJgVdfBHgLKVhc03wQLfpfd7JxnThNWDcJRzzlKfFeAdM7mZd2EkI5yHDoy47eNhgISQa++/oZvU2UaE4i0DngZWlry2xhNNSuKNebFPQs6RSwCa2/GTC2Of8ngMgB13chZwRxE4NdAvV05yqn1wUZo3hHxo1vl5XlJ+itUQnGcSyehFTlERxJFmK3PbBxmgOs8HRovnZ3/jbiNjfugVlITUIKQsBqzHZR4yEyfS4O/Fh6kuT2Zp2mHbQZrAR0EQZkQdHNtKbyugis7HxQLPCRI7OegHZOUK+XuncYjxfPBniyu3h/X2u8P/+4dbflTXgqsSkXVoAuH9QCw5TG5ar9KAZW6gDOC4SZsHr7gKyLcWATcBSrbxVJRHU6xzYusqTKpvvYQH8ggixjnxXOLJ5w5X8gL1TF7Yt8tVNxDO5hg9imME8vIBUQaHFVLV+GhVRmROzvPun6sa2XC0F6FRLj8X2H1ZIgGw/2HyUeTRP/lBLWcH6W0QTjRpWmtI/8yXkp7kKg3NCSE5mgtb12BUOpVMHeI+a17iIjZkoPd+nObG8IrF7AcE1XO8AH9XopaqATzNe+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(376002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(921011)(41300700001)(2906002)(7416002)(5660300002)(4326008)(8676002)(316002)(6636002)(110136005)(66556008)(66946007)(66476007)(478600001)(38100700002)(82960400001)(8936002)(86362001)(9686003)(6506007)(26005)(6512007)(83380400001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n6TjfA4TcXtwMHjG719znIwMDh0m0O1JPoA7ZjNgKNm+VFRSQx+Bx5ubxtRL?=
 =?us-ascii?Q?6DCJ3vCM/JcEeSW/a+CJvAoZMKvczMzIKnx2tRmjfaLINbOhXTUSfLcz1lN/?=
 =?us-ascii?Q?FuF9lacU/48OzXbdvYhD7ToIzUiBXzj02HHtp7/ePSJX1mwHKRAdYp5D0lZz?=
 =?us-ascii?Q?QXFPFyOnfgeOBNtIeThlCaBzwLRULhdAs+7gcsS7SIas1x4M/0XuAy6Bbral?=
 =?us-ascii?Q?oDQrq1hjsmbixQmzplZ1BEH0GH0f6NdDe1lgMAYXaP/6DZ+H0DUj/PRH2Zru?=
 =?us-ascii?Q?2Lq23BHveH0yYc9JLAkRctAbGNs/YtmM9OQ0dcaWnCSHKaCiPXP57P38gjsw?=
 =?us-ascii?Q?u5wqMl1Kgbil1NGS5S64XRUpqD3xClHmkTZb6NWeRcpb29hqVrhYb47orolQ?=
 =?us-ascii?Q?ifiJyKa/FbHVVk27daIgEAnzUZUKJ5nbEZzPpBA1XMrm0WAJLWVaJ3S9viE3?=
 =?us-ascii?Q?QSfkQ/5efKf+1kACb1BUHejK9qJntCvqDKLr2zBwzLnQIpLk2E4Zj2hpQPwr?=
 =?us-ascii?Q?ZdrFvjBxFL1CncE8EWjXc+Bnn3GeeQvst/+qtNT1MlCDBajkuxz1itWATysN?=
 =?us-ascii?Q?grT/kTFc4R9PKiif83LUgEBl1sYDqXv2aKzA4kOk6jRqV8OyhHtjdE+AezYq?=
 =?us-ascii?Q?2AvXYYsUz5Q+QFmGH3ilENOXvZ3irxy2znwP5yuH6EjnaYA5Va+BkyknPabq?=
 =?us-ascii?Q?bEtK4VZYpAd3I2WFx7uajGz8+mn2YOO1WvkZ0NtgKy61wVbMteoqSaPd44ys?=
 =?us-ascii?Q?zzpJw0iTjCZLRucuOpM/ZGzxEFbAke62RAMOh+9I8pfYNJlu7QcTyoO0u5vx?=
 =?us-ascii?Q?kAeGcDmkACsEZsWOOFRN3d124gSdONV1S7ydw8N3yfEskGjLVR3DD/rsIAoU?=
 =?us-ascii?Q?eE4y+LQOJ/iHseIkqqwUusZPnEEMXT1f0dFaRsw1DSl7Dh908Debi8J4fDeY?=
 =?us-ascii?Q?c36SZ60gpMgspLEfNsJ6eV+pP/WLrpMd8+4O0bOL/DEbBfiG6uMThvdsV5LQ?=
 =?us-ascii?Q?wvrjT0T4fgloyjAcBe572yAkhnl/hMVCDBj7Z3osuq/eAKqA1y+MemPvP3Ma?=
 =?us-ascii?Q?TBDdcK/alvpdMkWmASXBUIX8qLfrJrqj+SAlunM6874u5Dk9+8cBljEdZNw0?=
 =?us-ascii?Q?Ssw9uSlo41iElpvwRNIXym5f2oq1rdm0SCXiD5cowaMNB5TIhOPW4bzb07bB?=
 =?us-ascii?Q?qsPTDauWVwRPrHya/Qe4jm1tsKPe0UF1an8WbR7ggctX6ucQ0NHKkhNt60pK?=
 =?us-ascii?Q?jI/ZwTzayi8LUKO2CfkiKaGnbDzqUKiyGY+zmLutHFDov6wYo7glhyF6dNmy?=
 =?us-ascii?Q?loBOfdidbpIO5/hN7aR2Z2yOlrwusPMeCzMZeJOIYUoB0sYNFeYXtI56/GhZ?=
 =?us-ascii?Q?4K3ml/JGVjkk4/B+0C1wliow7xXRzPjZ/bkjUI8fyX3S9CDAg74sgEGKM9L0?=
 =?us-ascii?Q?w9HVebPyj1F8EXypkblGknD7vO+0Y2QI/IVphhT+j2dWXBS5RMhHJV24VV2o?=
 =?us-ascii?Q?k7uTGF3HwbEWL9qc87Nbyxlcw04l5sF585CUmrEPMxAjRewd3oL4kUu32Uot?=
 =?us-ascii?Q?8JV5qubfTX1a5jo2adAYW05qvWJwAHqGwcpSxtE8X0mLhyWySpo+6n0rTvU4?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2003e4c-7054-47a9-06ab-08dc0bec89ad
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 23:42:53.1675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+dpg5C0nq3Qs+tM+mcvDBt9Bz/ck/EkAfOZB2RbmZEO99+W4LWLxTncQAXiWKWNBduYbh3A0vxJXao5VBeOM14+CYCT0Rrd6sGyZT2oRd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5983
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> numa_fill_memblks() expects inclusive [start, end] parameters but
> it's only caller, acpi_parse_cfmws(), is sending an exclusive end
> parameter. 

This reads backwards to me, numa_fill_memblks() is currently doing
*exclusive* math on a inclusive parameter, and the fix is to make it do
inclusive math instead, right?

> This means that numa_fill_memblks() can create an overlap

Perhaps:

s/This means/This confusion means/

s/create an overlap/create a false positive overlap/

> between different NUMA nodes with adjacent memblks. That overlap is
> discovered in numa_cleanup_meminfo() and numa initialization fails
> like this:
> 
> [] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0xffffffffff]
> [] ACPI: SRAT: Node 1 PXM 1 [mem 0x10000000000-0x1ffffffffff]
> [] node 0 [mem 0x100000000-0xffffffffff] overlaps with node 1 [mem 0x100000000-0x1ffffffffff]
> 
> Changing the call site to send the expected inclusive @end parameter
> was considered and rejected. Rather numa_fill_memblks() is made to
> handle the exclusive @end, thereby making it the same as its neighbor
> numa_add_memblks().
> 
> Fixes: 8f012db27c95 ("x86/numa: Introduce numa_fill_memblks()")
> Suggested by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  arch/x86/mm/numa.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index b29ceb19e46e..4f81f75e4328 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -974,9 +974,9 @@ static struct numa_memblk *numa_memblk_list[NR_NODE_MEMBLKS] __initdata;
>   * @start: address to begin fill
>   * @end: address to end fill
>   *
> - * Find and extend numa_meminfo memblks to cover the @start-@end
> + * Find and extend numa_meminfo memblks to cover the [start, end)
>   * physical address range, such that the first memblk includes
> - * @start, the last memblk includes @end, and any gaps in between
> + * @start, the last memblk excludes @end, and any gaps in between
>   * are filled.
>   *
>   * RETURNS:
> @@ -1003,7 +1003,7 @@ int __init numa_fill_memblks(u64 start, u64 end)
>  	for (int i = 0; i < mi->nr_blks; i++) {
>  		struct numa_memblk *bi = &mi->blk[i];
>  
> -		if (start < bi->end && end >= bi->start) {
> +		if (start < bi->end && end > bi->start) {
>  			blk[count] = &mi->blk[i];
>  			count++;
>  		}

So I realize I asked for the minimal fix before a wider cleanup to
'struct numa_memblk' to use 'struct range', but I want to see some of
that cleanup now. How about the below (only compile-tested) to at least
convert numa_fill_memblks(), since it is new, and then circle back
sometime later to move 'struct numa_memblk' to embed a 'struct range'
directly? I.e. save touching legacy code for later, but fix the bug in
the new code with some modernization. This also documents that
numa_add_memblk() expects an inclusive argument.

Note that this would be 3 patches, the minimal logic fix as you have it
without the comment changes since they become moot later, the
introduction of range_overlaps() with namespace conflict fixup with the
btrfs version, and using range_overlaps() to cleanup numa_fill_memblks()

diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 1be13b2dfe8b..9e2279762eaa 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -37,7 +37,8 @@ extern int phys_to_target_node(phys_addr_t start);
 #define phys_to_target_node phys_to_target_node
 extern int memory_add_physaddr_to_nid(u64 start);
 #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
-extern int numa_fill_memblks(u64 start, u64 end);
+struct range;
+extern int numa_fill_memblks(struct range *range);
 #define numa_fill_memblks numa_fill_memblks
 #endif
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index b29ceb19e46e..ce1ccda6fee4 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/topology.h>
 #include <linux/sort.h>
+#include <linux/range.h>
 
 #include <asm/e820/api.h>
 #include <asm/proto.h>
@@ -971,20 +972,17 @@ static struct numa_memblk *numa_memblk_list[NR_NODE_MEMBLKS] __initdata;
 
 /**
  * numa_fill_memblks - Fill gaps in numa_meminfo memblks
- * @start: address to begin fill
- * @end: address to end fill
+ * @range: range to fill
  *
- * Find and extend numa_meminfo memblks to cover the @start-@end
- * physical address range, such that the first memblk includes
- * @start, the last memblk includes @end, and any gaps in between
- * are filled.
+ * Find and extend numa_meminfo memblks to cover the physical address
+ * range and fill any gaps.
  *
  * RETURNS:
  * 0		  : Success
- * NUMA_NO_MEMBLK : No memblk exists in @start-@end range
+ * NUMA_NO_MEMBLK : No memblk exists in @range
  */
 
-int __init numa_fill_memblks(u64 start, u64 end)
+int __init numa_fill_memblks(struct range *range)
 {
 	struct numa_memblk **blk = &numa_memblk_list[0];
 	struct numa_meminfo *mi = &numa_meminfo;
@@ -993,17 +991,17 @@ int __init numa_fill_memblks(u64 start, u64 end)
 
 	/*
 	 * Create a list of pointers to numa_meminfo memblks that
-	 * overlap start, end. Exclude (start == bi->end) since
-	 * end addresses in both a CFMWS range and a memblk range
-	 * are exclusive.
-	 *
-	 * This list of pointers is used to make in-place changes
-	 * that fill out the numa_meminfo memblks.
+	 * overlap start, end. This list is used to make in-place
+	 * changes that fill out the numa_meminfo memblks.
 	 */
 	for (int i = 0; i < mi->nr_blks; i++) {
 		struct numa_memblk *bi = &mi->blk[i];
+		struct range bi_range = {
+			.start = bi->start,
+			.end = bi->end - 1,
+		};
 
-		if (start < bi->end && end >= bi->start) {
+		if (range_overlaps(range, &bi_range)) {
 			blk[count] = &mi->blk[i];
 			count++;
 		}
@@ -1015,8 +1013,8 @@ int __init numa_fill_memblks(u64 start, u64 end)
 	sort(&blk[0], count, sizeof(blk[0]), cmp_memblk, NULL);
 
 	/* Make sure the first/last memblks include start/end */
-	blk[0]->start = min(blk[0]->start, start);
-	blk[count - 1]->end = max(blk[count - 1]->end, end);
+	blk[0]->start = min(blk[0]->start, range->start);
+	blk[count - 1]->end = max(blk[count - 1]->end, range->end + 1);
 
 	/*
 	 * Fill any gaps by tracking the previous memblks
diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 12f330b0eac0..6213a15c2a8d 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -307,8 +307,10 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 	int node;
 
 	cfmws = (struct acpi_cedt_cfmws *)header;
-	start = cfmws->base_hpa;
-	end = cfmws->base_hpa + cfmws->window_size;
+	struct range range = {
+		.start = cfmws->base_hpa,
+		.end = cfmws->base_hpa + cfmws->window_size - 1,
+	};
 
 	/*
 	 * The SRAT may have already described NUMA details for all,
@@ -316,7 +318,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 	 * found for any portion of the window to cover the entire
 	 * window.
 	 */
-	if (!numa_fill_memblks(start, end))
+	if (!numa_fill_memblks(&range))
 		return 0;
 
 	/* No SRAT description. Create a new node. */
@@ -327,7 +329,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 		return -EINVAL;
 	}
 
-	if (numa_add_memblk(node, start, end) < 0) {
+	if (numa_add_memblk(node, range.start, range.end + 1) < 0) {
 		/* CXL driver must handle the NUMA_NO_NODE case */
 		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
 			node, start, end);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index a82e1417c4d2..e6c4ffc6003d 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -111,7 +111,7 @@ static struct rb_node *__tree_search(struct rb_root *root, u64 file_offset,
 	return NULL;
 }
 
-static int range_overlaps(struct btrfs_ordered_extent *entry, u64 file_offset,
+static int btrfs_range_overlaps(struct btrfs_ordered_extent *entry, u64 file_offset,
 			  u64 len)
 {
 	if (file_offset + len <= entry->file_offset ||
@@ -913,7 +913,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 
 	while (1) {
 		entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
-		if (range_overlaps(entry, file_offset, len))
+		if (btrfs_range_overlaps(entry, file_offset, len))
 			break;
 
 		if (entry->file_offset >= file_offset + len) {
@@ -1042,12 +1042,12 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
 	}
 	if (prev) {
 		entry = rb_entry(prev, struct btrfs_ordered_extent, rb_node);
-		if (range_overlaps(entry, file_offset, len))
+		if (btrfs_range_overlaps(entry, file_offset, len))
 			goto out;
 	}
 	if (next) {
 		entry = rb_entry(next, struct btrfs_ordered_extent, rb_node);
-		if (range_overlaps(entry, file_offset, len))
+		if (btrfs_range_overlaps(entry, file_offset, len))
 			goto out;
 	}
 	/* No ordered extent in the range */
diff --git a/include/linux/numa.h b/include/linux/numa.h
index a904861de800..ef35c974e5f2 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -45,7 +45,7 @@ static inline int phys_to_target_node(u64 start)
 }
 #endif
 #ifndef numa_fill_memblks
-static inline int __init numa_fill_memblks(u64 start, u64 end)
+static inline int __init numa_fill_memblks(struct range *range)
 {
 	return NUMA_NO_MEMBLK;
 }
diff --git a/include/linux/range.h b/include/linux/range.h
index 6ad0b73cb7ad..981fd4f7731e 100644
--- a/include/linux/range.h
+++ b/include/linux/range.h
@@ -13,11 +13,18 @@ static inline u64 range_len(const struct range *range)
 	return range->end - range->start + 1;
 }
 
+/* True if r1 completely contains r2 */
 static inline bool range_contains(struct range *r1, struct range *r2)
 {
 	return r1->start <= r2->start && r1->end >= r2->end;
 }
 
+/* True if any part of r1 overlaps r2 */
+static inline bool range_overlaps(const struct range *r1, const struct range *r2)
+{
+       return r1->start <= r2->end && r1->end >= r2->start;
+}
+
 int add_range(struct range *range, int az, int nr_range,
 		u64 start, u64 end);
 
