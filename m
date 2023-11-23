Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJ40HxE9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B88191
	for <linux-cxl@vger.kernel.org>; Wed, 22 Nov 2023 17:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700701345; x=1732237345;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bjStfduGcSvMemCSGmFt0Wo5MIQQ6Y0Pn/jmA8rgrzo=;
  b=RJ40HxE9g7T6IKGKWjrANjpoKFe0XXFnB9BhM6M0tHzCiU9d7/8H866Q
   3hNJ09tNIEqfK0q8m9emX3l+EP6YZfO2p4qvr6TwL36BF+5W4C6ZtAc8W
   6fJlrWW1v1zR0RKr8OO81n2XIzjLI03oUpeqi+f+USLneSyrET71i8nrP
   OSjxAME5rhXvfs0o8XJEqdpLKpBFT9tlqYc80JssO6IANpgJffUXNAyI5
   8oxN8EhepXDJcAaH+HZlH5+cOrIzlpIhr9x5ryEAf590cD8n9gi4MTjAm
   AKlKDQcBeCTyJhFgiOQoxmCBNwVHCqqNhG73UgL6RA2JM/iPxz4TXT2Uz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5365612"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="5365612"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 17:02:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="760527724"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="760527724"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 17:02:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 17:02:23 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 17:02:23 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 17:02:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ar4s9tN18NEAmMdrEONgG6HyKU9hin7CDo5QjShuaeEANMQQE7IvuydDmDNB+8WxVSDsiiEA7Z02mas1XWfZ6PjpbULD+WH/X0ItpkmNJbWUj98xzS6fUcE//6iVr1Dt83JPUprrAwvl3vvX+JFxasq+ooy/Lfir5ysTdhq4sg46ggRn06vqAOXAm/vUqrhAnZyUtT2vgHCvMuQxfSVjhbFvGmq9/8gQI610N3tWaH29OcO9PHcFO5SEor67AgNuHQLmY9mmXnAPp1QQNLpBJxvGayFmedqe7iiVP8XGoqXq9o068fHQ02s7zPZMACHBD9CHbzhQ3qZs7+sQsoshjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFyUtUBnr677WR8nGjLCe0QAlHtK9XmRdk5S1nAll+w=;
 b=Bxf7MsMXO6VwbivXUTaoKcLajkroQcfUFzQfrBK5p8k9VQB/eaQrMdTU8XXs+xEYWYPNuWwRZ+ed9RVLVpIqGRfJMQ+2KrwroTQ9OBMoYs0+TbryxCYlJHAG8Ayd3vDmfxO0vXYc+HZofGcbsiL2m9giXnOQs9oUhEi86ZQR/pJvkMi1RCiSD/xmFaI2pfMkOzCDdYQb3BMNFbM6fqm+gKoV50rVcDtx5Bs72vy/RUx/fWSycXxjZSt5vuXz+zSXhHW8kW780eZymnM72rHY+QGSM7Ja8EUQjbpd4aHn4gXCcduoFEiiAwVtTNfNikORbngwfAQBel+HlbQwDN/YdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5538.namprd11.prod.outlook.com (2603:10b6:610:d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 01:02:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 01:02:20 +0000
Date: Wed, 22 Nov 2023 17:02:18 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<peterz@infradead.org>
Subject: Re: [PATCH v3] cxl: Add cxl_region_rwsem around commit_end write
 during decoder enumeration
Message-ID: <655ea49a7ce96_b2e8294c7@dwillia2-xfh.jf.intel.com.notmuch>
References: <170025232811.2147250.16376901801315194121.stgit@djiang5-mobl3>
 <jhsumngltwjkwpa2o2ktxwjujmuzdzrza2m4fyd44ieva3l2ca@trrhklq6evtg>
 <655e75e929fc0_b2e829478@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <655e75e929fc0_b2e829478@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:303:b8::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5538:EE_
X-MS-Office365-Filtering-Correlation-Id: bd75bf14-d67f-4eea-dfd2-08dbebbfd884
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3YXHsF40ZZcBjcIPZP4Yaq6tUF6fKkOb5sklboH1CQ0gYuc25W+FNy61f6JfWgoFMxUlaBIgMHfrSBvORStMQs2/r+9jnecVcxSUMvaorbTtCKKJT8gXOPHf2A9qbAhXy2R4TDSI9TgKkHprtk1ksY7pV4YDaRXCAhQRSRcKV0MsKtq56ZRh6uUIBUk7Yhbk+YPbrLJhO3d6tmiwUccKE2EYeMCbU5t/rHcRZX7ejvlFc6g6+jGQ4xu7eG6o2kefAq0XGtpFHQzrl4aivIESsR56ediWoNvANb17HZpmLGEOcSfzpHkhFbVmTyTkM/tTuH6E3EQ30dFqx3DEwSIDcDhUvYeaBDxY35h/IG0aSZ+KVoxh2SaLrQWPhecNpf7fya/Ma8DZWDjEMJ8MFiWYPj0I2IsQxF+6e+jsyi4zfD6uZeCuU6TBoor2dFEAmyeUWmiuoptGHh1YPU4dR7NmhbvqUHJ6N1UtI6SUhp2aUhf8l9ZEHJ3SmctFr6GluTJHFnKzJlsjbILLky/V+S0mpjLH9BMp6FARA0U2Ykj2zU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(478600001)(966005)(6486002)(2906002)(5660300002)(86362001)(26005)(4326008)(41300700001)(6636002)(316002)(83380400001)(8936002)(8676002)(66556008)(66946007)(66476007)(82960400001)(110136005)(6506007)(6512007)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nKic3FYEyMQ1+rxuwe/k16kaR8H+7kEvJwsbfEGyZTlJksi5qrNAjx1ZOMvz?=
 =?us-ascii?Q?zUV63fVDP7Vo6iRjvzKYpP9HScRO/2qU+v1+/L9t8FWTciBo4Coadv6ACWKF?=
 =?us-ascii?Q?bQvHsxSviySH2QvfovD8S+on628SXAY41MU627DnidFjVMSPFCuVB44eFeg3?=
 =?us-ascii?Q?jSxWMhfXgQpK/aOsdqhNtZoXZiFiqzUucOwMQxiKZfSwUj414FtQliLrvZEq?=
 =?us-ascii?Q?tzkUP6UGB0v8OR7amge4Fo/2OvLZELRsbCPzYdJNngUD0stK5Lny+r0zwf2Y?=
 =?us-ascii?Q?td6EBe3Jhuy8D0c5lGOHZX977jRMIMMW14EDzEieA08uqCbyRGiHAMo4PG95?=
 =?us-ascii?Q?uZBLd97Zixg4LglEHhALcMMhGCpEXT4/qMpoEp1IixuaR1BVerphgKviy7eB?=
 =?us-ascii?Q?JBcWcuI3Q7xXZ6Uy/te6U/iIbVWMqy1qxHL/1aJAPjKHTSi/rtnIMaOmfKJY?=
 =?us-ascii?Q?LbuaSJ0pn32hQk47lBwzC27VOqWWQeyFJE10LisodNSVlTevbYPLyASAuj4p?=
 =?us-ascii?Q?CfivfuWV9k1MjL3x7PkS/jzsK5celbIcQ2WbwRQUiPxJf4vxrSRMwj4LIh02?=
 =?us-ascii?Q?wP6ZTJDaellFMjkV71u23w+bWGRfxv8JRRMI+WpTxS3nW2XAz3mzf2gstCTe?=
 =?us-ascii?Q?zxVcfU2W99lBjCa5oqsVzMS6iMH2uFtjI9c5d5aYSwdueXY98WDBPVqKwEh9?=
 =?us-ascii?Q?u1UqIjfsyBjZSSvJGY/JnL7/l4POUBwxOq9I42b+QHW6ixAnhqln3sJ4a0UU?=
 =?us-ascii?Q?Wpcn4t/j2ayufo/N214vcFrsurmPii9PUOZMXIalBQwnwG5d4mccbX4obSCH?=
 =?us-ascii?Q?NZGU8oJJCbZF19RXhDaTSUDdmkdNs+Olo93SMJib0hdwO3QISkNQ4uOJX15A?=
 =?us-ascii?Q?izyJ9osYb8ORvahPzL9N2wdwbhqkLmVBTensGpRKYHQnNO+3ecz0MdgMT+xI?=
 =?us-ascii?Q?2iOwCY7+4MmJkH/BeYCSfZF76olA88vFit1OznQSQNh/NnQmZ1XW7H59Irp3?=
 =?us-ascii?Q?uv/FkCrUMhC/aDQ5jwS2umHjzyIsvkfGdPf0qA6xjk2VjjLyDl7W7186PaHp?=
 =?us-ascii?Q?zutSENVqqKRDcCzmwAWTT392NawmVl8DNyEBX/REsYjoxWTlyH5UUkK7gdy3?=
 =?us-ascii?Q?C3+6Cr/sYGRfTxRN2YTS18C+YuwymdPwrREJzPoiTzwVeyVIdq3tTkMO9vrb?=
 =?us-ascii?Q?zdGbbBFAif7Z8T2fMgdA46HRC7AytwAeksQS7TTJdWfgohyzm1WgRxyRmNnx?=
 =?us-ascii?Q?nnOFzWDLxZak4icL3B1ZVKTBEBFVrtiibGgkDhdAMXo16xNuw2QawOAvwCuo?=
 =?us-ascii?Q?n6hsha5/TivU+c3Mz1Z8R7yzWJDXmAbQm5gTJW4usYViV1AJYgPBBVOs1Sia?=
 =?us-ascii?Q?kdlxgj8sbLjCFGEwgE5vsMwb33mUbXYVqr8A2xW30H9GBGluXj+oXK1vZeZ0?=
 =?us-ascii?Q?dnvyeF7uNIIulrlgrL0djG8KlEsmVvCy8UBP3dHMwgSwAFsSva5y0fQB+ckR?=
 =?us-ascii?Q?Nncq+Y5VfJp94CJg6yFfi0x95czQL/Rmk59GC4wDwAE99otWoUmelE/edNr3?=
 =?us-ascii?Q?5pYWcnLmHs2RvQxajr8cLuGtnPsCflB/hSXFBqRnvNKi3snQahdrWFXCGHUb?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd75bf14-d67f-4eea-dfd2-08dbebbfd884
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 01:02:20.8115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZH5T9+eFiEbduAsi/lsbRtXZWOHXNNe18o7DYqV7axSd28TYIFThiOK7eqhS9oBcdHdTAOT2cml9JolHujfOxg+XpGnaPFMYpz7Mp/yurk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5538
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Davidlohr Bueso wrote:
> > On Fri, 17 Nov 2023, Dave Jiang wrote:
> > 
> > >init_hdm_decoder() modifies port->commit_end without taking the
> > >cxl_region_rwsem. An assert splat emitted by cxl_num_decoders_committed().
> > >However looking at the code, it looks like the write version of the rwsem
> > >needs to be taken due to the modification of commit_end. Wrap the write
> > >version of the rwsem around reading and writing of commit_end.
> > >
> > >Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> > >Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > 
> > Uhmm but do we expect concurrency during the switch/port probing phase?
> 
> I answered that that detail here in response to Fan:
> 
> http://lore.kernel.org/r/654eb8ed72ced_46f0294c@dwillia2-mobl3.amr.corp.intel.com.notmuch
> 
> The takeaway is:
> 
> "I am in favor of adding the locking rather than depend on a subtle
> side-effect of how CXL operates, and to avoid adding an unlocked version
> of cxl_num_decoders_committed()"
> 
> I will add a note to the changelog to that effect, and drop Fixes: since
> the lock is not strictly required for correctness in this path.

I rewrote the changelog to this:

Author: Dave Jiang <dave.jiang@intel.com>
Date:   Fri Nov 17 13:18:48 2023 -0700

    cxl/hdm: Fix a benign lockdep splat
    
    The new helper "cxl_num_decoders_committed()" added a lockdep assertion
    to validate that port->commit_end is protected against modification.
    That assertion fires in init_hdm_decoder() where it is initializing
    port->commit_end. Given that it is both accessing and writing that
    property it obstensibly needs the lock.
    
    In practice, CXL decoder commit rules (must commit in order) and the
    in-order discovery of device decoders makes the manipulation of
    ->commit_end in init_hdm_decoder() safe. However, rather than rely on
    the subtle rules of CXL hardware, just make the implementation obviously
    correct from a software perspective.
    
    The Fixes: tag is only for cleaning up a lockdep splat, there is no
    functional issue addressed by this fix.
    
    Fixes: 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper")
