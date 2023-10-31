Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7AC208A2;
	Tue, 31 Oct 2023 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBCf5Bpi"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D050DF1;
	Tue, 31 Oct 2023 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698789897; x=1730325897;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xaQ16U2ncUl84YQtywMBtKjSEMFoYkZTjmrwa3h5ihk=;
  b=BBCf5Bpi9vK3C07Q2FGaCtA+CarToARtP6NeSy1A9YrBiAnwjYAmzsvb
   q398QE2KB85INQ9S8AzJHsZqXGjrUHZMfGyu/3O6cHxZ0QCbMWJJar3Jo
   uaUM+n0ZMVn5q5QpdA2hSPkLeuuDc8LU5U/xW+QGNeq3M5i0X+oMf44BY
   GY4rWPt5kM+tn5UBtcfMNG+Xg2vGPYdHSOVc2peIG31sjVvAYLmeo7fcd
   QtW9Hb7JO+OFT6JJFNLM60DbmrfhJvL61VrmQzM78BTnTIeslBKbVUz4J
   KkoxntE3fWsokR4mCr+OSNPhUIOCMnI/D6i7dvSyLPZF5mOPO2/CZWx9v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="378769757"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="378769757"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 15:04:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="1007914001"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="1007914001"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 15:04:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 15:04:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 15:04:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 15:04:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 15:04:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNBIVnewfLEHgRWEVz9jK7B1uF666AlPHAcHT8gfZ3W3Ucr5bF07KmWwkoxXh9QL8sWMCL7YcCMukoMJ0xx4SJvW58PTa48uGcyzouR8FNBdjxyvQNw9bHBc/gLbXjscED2LExOa0a4ATDnYfPM0ReObAl4XPzIAZY5n1rgRD4ond1ZSpnw57td6NMmA/rVcDAU3NsMxinbP8j4s94IcHSKEXxIMdZZ7W/CNWsss9pNArAOVgnLd42YMytYle3H5s+D3KBCuQXKDIbwq2dhzwHl/dXTF5MokEq3264Qn8DLQY3NhU/HEcltu3oGKyr7ZmWHDVhskcbeCA+jWmNtKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/JdMWN1A45WaeR+HxZ/abonlPWTpN5MFAkLdOo7fX4=;
 b=B3Jjw/M5YGDNibVWKP6mcewfmNzyvNp5nIx+AkItI/OyJ/iNcVOf6r/iomKI8Kj2mPZnmxfMN5fy3ClC/zxXBhDgbfK5y1dZLzL9beeMMKPKaj3P3JIyzMngC2buzNeSWhttMaqVY1XpkwHE5RoT/zkxoh1t8PGMox4pWTQzb+MQKc/w4H+pFxfjebKEo1NDB+Ta1PftzNnz4P+4lPPiEGJ1KY2JqU2LrHGQff7KkROaeN5YYldqutzkMw1wcFw0U2EPmf6+jwNoZgMcLubPYe5/fFUGF5pZkE72MKn1QOohUg3IODE2nIyfFOys/m1sb7vfpJuZbVXv5R0kHglxDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM8PR11MB5670.namprd11.prod.outlook.com (2603:10b6:8:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 31 Oct
 2023 22:04:48 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6874:74cc:1c23:7f1c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6874:74cc:1c23:7f1c%4]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 22:04:48 +0000
Date: Tue, 31 Oct 2023 15:04:45 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	<linux-cxl@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 2/2] cxl/hdm: add unlock on error path
Message-ID: <654179fde285b_360f729419@iweiny-mobl.notmuch>
References: <60028378-d3d5-4d6d-90fd-f915f061e731@moroto.mountain>
 <63295673-5d63-4919-b851-3b06d48734c0@moroto.mountain>
 <65416eecf55b_780ef29464@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65416eecf55b_780ef29464@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR11CA0079.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM8PR11MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 76029d03-4462-4281-9908-08dbda5d6606
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6aUGwa9IN2vka3vfrUsK5+kNj10dBkW51RP98fcQ20njtv9MRr1SJyN/2oOexYMmv5lBRBP1eKeiQOsEdSBe0+fOvDkZ7xmeShM+OvA7IX3b0C2aqNT0Xim4sk1hwWMlelx/6WW33vUxuujBvmtcQrLtHrCNe1X297luuzEGeJ7nYAM2oULFVXmP8kFBHXFQyJI1IqBK1hGu1BbHu+9mvGi/OqcXuWweQUVIZEztsQ8s7N/DSwA1LKvklFTLztwU3VWNFrObx7u0BoLDaR1UskG3Agh8voLQ+YTZnbtI0p31Oh68rdFlVVOd0SamFi9WcKPXsQEGr1plyPW5aYxhNFndrWoQ+KsC3CCVjTJOwuw8DYC5Rjqo8jj9lnH1DZdKrcNQlrc8x6bASdNMmHyaO2D+kNb5PusE+PnrMXpx/C5RadrujK4AQ+P8mRYXOjW3/vIiX54b7eT1Q6eZ7pAAQ0OfjoDOYxN3Ete/UXccTc56IxM3y9lwPzchG4tVXRE8Dv4gfPMF8Ifa6klmPVyuWRM9w7iUiVkVD+OtP3kPyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(346002)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(966005)(6486002)(4326008)(8676002)(44832011)(8936002)(478600001)(41300700001)(5660300002)(2906002)(4744005)(66556008)(86362001)(110136005)(316002)(66946007)(54906003)(66476007)(83380400001)(38100700002)(82960400001)(6666004)(9686003)(6512007)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KZQW/2T2dmRNLihlotdOpTYl/MfbKnvlwxLoG+xtwwCHSE9ra1a0kwYpwrqj?=
 =?us-ascii?Q?2w+VR8ks27P/z5GZwrdYRN2Ppmnwu/u9UDZyRU6613VGaxJ7f9H48z7EwYao?=
 =?us-ascii?Q?D2Kn7U/ulXecu9wOfTOO5GQ7wICqqzNUjXCYsWkp8jBaAvT5a4lAIggFgN1H?=
 =?us-ascii?Q?oP2ZeTjP2AVQfWHqq7kJBt6Jxc1S6ZmzdTvzVIWV8TeQk/uYtANIwFKyc33+?=
 =?us-ascii?Q?YXQso51TtTC7SNosDo1pJTJp6QiY//MAqlVGTQBTEM7XYsnJz4D+GuDkfn9s?=
 =?us-ascii?Q?4lnOMIiYYREZQHyOA+0MJg2QclP3Do/j1JsIFnCrYZFEUeCv2pTx+108VXta?=
 =?us-ascii?Q?1xYnhkGNCESHDDqgjhrJSYfB6r7JkgBhyLFcEndx9wwm2fDBXqvsSrTvvn1B?=
 =?us-ascii?Q?H5qqSZUiHzTAfkUNPNin1+gS31yCduETcAAyL89ajJp1/n2OSb4TqOsw9PAs?=
 =?us-ascii?Q?/ElztUPQKuXyBegy8X+whokeCTuJrMSRxGM526jLV4cCMmmVOLpr7Lsr4nM2?=
 =?us-ascii?Q?/c2JN3JwYiPVM989lKCiETWtvU5aGicCo3clhaj0K0MNMYJPgBy2pzzwac9T?=
 =?us-ascii?Q?M4WCuqRfoLObzuT1OGrePfLXD/oS0MbrbNmZMwEMVSqdWIe+iD23ycVKpqk1?=
 =?us-ascii?Q?5/ixWBJbCYYxLby9xFlCG5NaireNjO7QbCk7RX91ZMPbhK8ZnYbJoCoNh5SD?=
 =?us-ascii?Q?8dN+kR5itC6XuEUva0qgP27Ad4nPDrVXJbjuFplfNsfHsuUidT3ZrCSQm+tk?=
 =?us-ascii?Q?J4BR0BTFIiBMBnyfX4S8ssgCZUVXJiOH+cmEwgxQ6WhABBUOCqacWdCoTo36?=
 =?us-ascii?Q?EqbFKH5kNGvSBgJdf3Xw0yvH4L2ktculKotJWZbkkZobD44Y/RSwCZVw963X?=
 =?us-ascii?Q?FOmOcpVrNzqNLYZOAC58BCpjLuF0ieVUmVw+ztTCeUsyS9LZvLlNeqK7MY/H?=
 =?us-ascii?Q?doVXDQ8VsGY6D4vMEKkGqNZWLLsmvobe7Ff0qU5paOV5kYE7fh+kuX1PEeE2?=
 =?us-ascii?Q?Q0tLPAipiT0qWTYjRPfYqv6OVmVL0b0xVHf3lGLsL5IL/BAxQv+t2T4e7UaL?=
 =?us-ascii?Q?6xjXAPXWyNZ2q6RGT/X2xAI0DkR2/EU2ZjVLIzi5g/k37ezqHOUsqhuj5wPs?=
 =?us-ascii?Q?paQlGT2JSwK/ZMQMQPdJ89hk1inPvL8uHL/tPZD0o1sTmTPiUW1uS2K8piYm?=
 =?us-ascii?Q?AAokfqxg17IwstffvVbzgSQlViijwDNvKHRorFF2Moed4HehW5Mo/0tA8IWG?=
 =?us-ascii?Q?sw7g+7c1EOcABe+bQARKLu4/32rSJkGAHYq2E8KQOOV0x1v3Alm5bHOpn0AA?=
 =?us-ascii?Q?jpOEiczRYIaCRPB56Vc82XpQWlA41roiPR4DHrL6S8jINOqpJWNuKQhVho2h?=
 =?us-ascii?Q?EWvZ4iukQEXQUTT6nHqrurgo0TthpBryEXPCYJLVkPWDl1/sQ/wFUf596y5s?=
 =?us-ascii?Q?1o/Gb6Dy1Rofu/ojbPbqtgJgWp2aR2iWc9iiLiw98uZ5J/VLOYFY+nhmW40n?=
 =?us-ascii?Q?QX/GKS3xoBH+7qHZCvKEWsiCDVPuPwfukVQIwNAzXXoOhqdvDEZG4rHKgUNb?=
 =?us-ascii?Q?mWAkEH5P4147sTVK+Pu1Jsc1anJu03cH02KSpbWL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76029d03-4462-4281-9908-08dbda5d6606
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 22:04:48.3324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hok7XS8F0gwberPZOt+/yj/S2MEZQkldRlZFzir41edKxqEqF8/LlCAMwd9MGxlJRxKfe1VMFMlamETiGpgmNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5670
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Dan Carpenter wrote:
> > This error path needs to call up_read(&cxl_dpa_rwsem).
> 
> This looks correct for what it is, but that error path is a "should
> never happen" situation. It would be better to just eliminate that
> possibility altogether...
> 
> -- >8 --
> Subject: cxl/hdm: Remove broken error path
> 
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Dan reports that cxl_decoder_commit() potentially leaks a hold of
> cxl_dpa_rwsem. The potential error case is a "should" not happen
> scenario, turn it into a "can not" happen scenario by adding the error
> check to cxl_port_setup_targets() where other setting validation occurs.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: http://lore.kernel.org/r/63295673-5d63-4919-b851-3b06d48734c0@moroto.mountain
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")


Reviewed-by: Ira Weiny <ira.weiny@intel.com>
