Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jvd70Jkt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61C6A4
	for <linux-cxl@vger.kernel.org>; Mon,  4 Dec 2023 16:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701737002; x=1733273002;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LVCbeiwh+GOzSiZERR8HHyf0LVlK8umGIe3nN3dExpk=;
  b=Jvd70JkthcMS9zJ2dR140jnhgCMCd/jQ/h/TMP2fj1jgftaHLeHObZNJ
   BqTPOstIrpW2DS6EJtngoukSzpdy7mNVakoK7IChcv2wGAdt0Rij3iOJV
   XdifsCkL8vLkt6KSxIGUmiCFT3/vrxei14WhnkhQsL2+plsQehEsRD4KE
   x9FY8uED9EaMzoNJoL3w39VuMouNC57h4wYS2+H3xjRxc3n5CsbUltr/M
   WaM+oPIEt53OLr4IX8AwxWQbXtBbViflVUP2HVxOcIVJnRQ6HKtZR3hsf
   pTyMHk3B/g0NE9acL7JLv1iV53D3ghYuiQpFYuntUCEtt8ehMlDqUaCr7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="876393"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="876393"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:43:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="12143562"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 16:43:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 16:43:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 4 Dec 2023 16:43:11 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 16:43:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEGkT4YgzhHNq7x/q6hrCkuwyW5mydxmfYctt+RVa3uU4SaIw7aTN1LUcb3xSjy/qhzJy5zCilSeq0yVkzKuz2TfjL+ZJ6w5QdZnf38rSPiifuaFz+YQw2Q3SvTP90pfA3vMSn18ib06KJoZKvJcdmj7TaNat6strBq45pTM4DxaFcuzZUYnEjC0qR+j4Wfa5Ag3TADtS2axvp439mclb5m9AaJh6nmonUCKbBWpcERrnUQy9JlI5Xc3+KVeeYNCoPdCVLl3TeiVigId2LZfNa9uWODAsJYTVqlZ7HKHFzmKvf15fYL6rB5xAjC/Gqs79cPXxiuwI2bIlZb5OoND0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziufQZETQmG0YLSvpzmA2/yaBWZJ6QFfTIQFn1Yt5jA=;
 b=McTcgnvwgz+GIUs+Z0VOAAnQsaVkRKVcpr4kkingSo5aI0vzkHEwPeRSFGSdcS/YOLBo9o9Q6Ld8YizyedOjE13bmRKtiYvsuPNuulPCDns1ysKMELbN6FUQaH9BMMKLADhMBIuS5VpAKqE8fqxbZHtP6NDXqmrgd5r3Iz2+UPNIEg1D/PSlQSAqNy+om3umntqSa7YwmyOms0FHMmroFy1W0mKZv2tYiiDGWrZvm3MvqiSUjgoA1znRImmqhl7GOe6nEFDBDc/rt75QJX8XNv5otepA1ypcDaRBe25f8WxL+PP+EIDi7FStYUQSMmFXRgySgGN0jncyR3J2VeJmDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB4782.namprd11.prod.outlook.com (2603:10b6:a03:2df::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 00:43:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 00:43:09 +0000
Date: Mon, 4 Dec 2023 16:43:06 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Dave Jiang
	<dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH v3] cxl: Add cxl_num_decoders_committed() usage to
 cxl_test
Message-ID: <656e721a3bc4a_45e0129458@dwillia2-xfh.jf.intel.com.notmuch>
References: <169929160525.824083.11813222229025394254.stgit@djiang5-mobl3>
 <ZUwFCM61s0864EA6@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZUwFCM61s0864EA6@aschofie-mobl2>
X-ClientProxiedBy: MW4PR04CA0139.namprd04.prod.outlook.com
 (2603:10b6:303:84::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB4782:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d39902-6f30-4e45-f86e-08dbf52b26dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHI81WAFwsGf+5GItDM1e3eCo71ofam/MuITzqoU4dtcIjQ+PCGR36HTUeojZJjoye/rH4HiDLGRVnLgQzbVAtoOWWu5CFH1ntDml98HsbG+Gbsy6YOP7lrp72LN9wt5vRxBLLLTr9waGd5pP/9ZiZU5BxlJXNYY0Tp/lNwcleaUeID7ue1M0NRFbo469GCujnIyCXO8byx9c2UDQtGDmeAGYTeX7OlxrecBRh60nw0IwOiC6GnOMfT86VczMeRPbeJ21N/7BygbQOm7me446Pz01uGZ4wQHrscbxQe4OtV997lxWh2xloV6yETHZoJlKznmVQNGT/BXCwmZwPD+OFbVT0ORVZfs7q9WqO3Azzx3XUnbPJGma+MoLhNGv2tRKhihJ2MKAfFZtVIwLxDD67HCUPQojdTv8T06Onr6iFZjQtatFTr6Mo4iwozxeK260SzUpGVwErzoEY3f2yFqlDM0RUkTSTXuUO2PbQwdXGOH78YqA3aW/iQmy/MXJWNrrlxwJaSZng41MZGl8EN9jW9QuaZ8zt/OIX9Yr+ux0doE2qQg+LItMKnqMoKeGSep
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(86362001)(4326008)(8676002)(8936002)(2906002)(41300700001)(6512007)(107886003)(9686003)(6506007)(82960400001)(83380400001)(6486002)(478600001)(26005)(6666004)(38100700002)(110136005)(316002)(66476007)(6636002)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?81Twjn7ZhF/tCTURGzbnGNkgvQjM+W+hMwRlm7lVUp7FgJJhJ2EzfYj6J+Mp?=
 =?us-ascii?Q?SO7T/lLZsvvp31CMCIFKnEXkZSjLnf9Xmuy/s2DudvvRlKF78ciqNhBsWSW5?=
 =?us-ascii?Q?wP4zpmTM3pyIfxceu8eGjb+xUAk/urNqjW8WFBpix+/I1wwyNzCXVLiHT+uH?=
 =?us-ascii?Q?XoUC12eSfutK8G3YgZf6IMomVldCdIZWAGT4M+ExR2ipu+679Gm229nQNgRC?=
 =?us-ascii?Q?M1uYWT4/WTIV4fza1MGs2ha4q6IcyT9fJwfFZWZNDrt8ahDra00mhZ+k2VwY?=
 =?us-ascii?Q?PaH/RFB/372AAT259LvKBZa0l4tVMjYy8KgCcTTwHCkQ58uL2L19Phhl7IoP?=
 =?us-ascii?Q?D5FmS40OLNtLYVy0awkzWuv4Hie0JjLGwLfUwkE9vydJadaiIxb3vNd8noYL?=
 =?us-ascii?Q?4cYEYUTOZnnlV3RqUcTGZrkjpRtnCt9f1uul0v3LnfVJFM19KUnMbB7epXe1?=
 =?us-ascii?Q?NwusvfF4TjehoJlpsX3ivlPmmlfJyBK0gj17YDCX1LrL+Y4Bpxv9Elz4COsL?=
 =?us-ascii?Q?N76vucVcc4T1VPYZP/iJLfVWgkUuqCTAzZcYWCtKyv0QX4nPbDWaZ8te00gN?=
 =?us-ascii?Q?pJLggKb2mQhxAuzMuhW0ulwX6fjQmwK80OGLhKjHwoEgOY9g71uLlG4EJgyA?=
 =?us-ascii?Q?ZtVAJHkaPvq/uTH7ycVKabDvkvWrbj8Ek1Hf/a/NGcwundsVMLkM5Z+LRFLL?=
 =?us-ascii?Q?mZCXi2Cz9t2BoLtgd2yXXcKI4OOse7TlXWCmJVs26CpwEcTEHkrRT1jX+32s?=
 =?us-ascii?Q?LP/jnBZbG8wjdgb0DliQWPWOnGeCOIGzq58JgQeBwfaup2cEbtP9gwY6SDRP?=
 =?us-ascii?Q?Yo2e3O5BF1Kg4ETpEyVBrhpe3WSFbE7jFJPn4HoPHyJ2QBTgGk8DQydbHFgx?=
 =?us-ascii?Q?jf51Vqr2lCv6mqLxfhDuvGaX49R/VkCkJA8kngLDa8CCIUHXULMBcHQTxoJE?=
 =?us-ascii?Q?FFlRIRXox7Hu0wYLg66Rv7mljgJ97ODf7C3uNC6jQ5PM1A6GRt3PJKYnuE7d?=
 =?us-ascii?Q?TYyRhftgsxg8h1jhtkBXCKmY/kZIG2wfQVSQ5J8jsVXxGAeAELADvn9E05XT?=
 =?us-ascii?Q?IVir5lA6ZZLTbzZwz5aeq4+2K+7FNCMBqB+xq/E2TQgE8QzzKxUiI+jFYswf?=
 =?us-ascii?Q?xparnikISzhFBfi4MDDx2iR+vVOJPu+odmoRxHrPm+UYuR2kM/K81+RKH7cY?=
 =?us-ascii?Q?oBoLS71Duc96R0oNctIPKjyCR4gCklWpK1EMlKQ49ERMYVQgU/To5MuLc6fw?=
 =?us-ascii?Q?AKuJnXD1GElR/URlSVN/8/+76MNa9cZmyMpmlsiGEezbWlUoZ98cbWa+8D/r?=
 =?us-ascii?Q?YPMqsjUWLXFYvcx/uE8nbrThfd1ErA7kWcOPBgRIYjFUTIo1crTo/JJJIDNk?=
 =?us-ascii?Q?Uqeum3rxWrRvqim+14V8ECQKGroeuI8rCxsJoZdqzyvg8v0k/N0+75y8ylgY?=
 =?us-ascii?Q?qFaBpRmHbL14G6Ikn6LPNF/yoiw7PfwC4HwQSZ9CF/TDxYC1TLBhmjnfjkRv?=
 =?us-ascii?Q?VhJBeFvtuB6VH+YGsp/mZM9EYAZd/GFd6Snw6qVoF/6ktAQd080G6ULojXXQ?=
 =?us-ascii?Q?eN0Z6ydnmF0IbIGbAahl+ShbVgaJnUehEv3DKVlNcxmIaV0erbwcxO3gWyxw?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d39902-6f30-4e45-f86e-08dbf52b26dd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 00:43:08.9675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FsR1qVN7ON409wHz/4Ik0PclXcrSCCRrMIvEFPKxtX8/+np5nuZq7DV3VhXx1qkYlVuIg2C8YJRXwi30w/ZWSYbSP12RWlRV9wObGcluVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4782
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Mon, Nov 06, 2023 at 10:26:45AM -0700, Dave Jiang wrote:
> > Commit 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper") missed the
> > conversion for cxl_test. Add usage of cxl_num_decoders_committed() to
> > replace the open coding.
> > 
> > Suggested-by: Alison Schofield <alison.schofield@intel.com>
> 
> Search for more usages of commit_end in cxl.c that may use new helper. 

Did you have one in mind? Of these:

tools/testing/cxl/test/cxl.c:672:	if (port->commit_end + 1 != id) {
tools/testing/cxl/test/cxl.c:675:			dev_name(&cxld->dev), port->id, port->commit_end + 1);
tools/testing/cxl/test/cxl.c:679:	port->commit_end++;
tools/testing/cxl/test/cxl.c:694:	if (port->commit_end != id) {
tools/testing/cxl/test/cxl.c:697:			dev_name(&cxld->dev), port->id, port->commit_end);
tools/testing/cxl/test/cxl.c:701:	port->commit_end--;
tools/testing/cxl/test/cxl.c:793:	port->commit_end = cxld->id;
tools/testing/cxl/test/cxl.c:825:		iter->commit_end = 0;

Only tools/testing/cxl/test/cxl.c:694 looks interesting, but given
cxl_decoder_reset() does not use cxl_num_decoders_committed(), neither
should mock_decoder_reset().
