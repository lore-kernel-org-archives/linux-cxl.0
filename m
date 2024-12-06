Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56774256E
	for <linux-cxl@vger.kernel.org>; Fri,  6 Dec 2024 00:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445403; cv=fail; b=SoljMH2su0wMMZY45TQyWZgjTJfq2v5SYRs00r6/RWoq6TvFMMdwKERTT9yXDxmrd4s3qxd3/NGr9rZNWNvHptS2FvS39TiH/F/GVfYXFZamubGxwKBDq0A1mmwpOlx+iNGXwSqjhr78WKrJv8cNbDm5iWxuawRV/JtOi3xO+8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445403; c=relaxed/simple;
	bh=/JOrFfIRbma2VayHNfY95gvO6NraEJnq4l5B5dr+zas=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q734dSgrHQfiLPC+13ow+BqQlPVWk/32E9KiOMWNPLIZp1qrLUngvsewjk7eZ9f11Qv5O6ghtj+9uXENlUG3N9v/ok3T7svKj6gLjr79ZVYh/AxS6qtOtydDA9FXZYItzOKLhsnyjKXSZObUcwecUcFalS5ojI/o5st0Cmzi5EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2laH+bY; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2laH+bY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733445402; x=1764981402;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/JOrFfIRbma2VayHNfY95gvO6NraEJnq4l5B5dr+zas=;
  b=j2laH+bY6GiB1gan+kV9ttuswi3eGFSX1HhL2Wb+ukWPhXEHF4yarT/Z
   yk7g9Min8InUIKvErpyE42CtO632b7Kj88PKJIGs3jamUqXEoolktx2o8
   zAqoyGzemqW6CdClM5aQbknt8+zUAck6fVx1sqx6vRNsAMucrP/FKbxte
   /9qcRNTlJQ/3OJFu4fhp4vZnDc90m+V7IEekg9ofTEIqjbgJQE/KqxbS0
   NzA4FW+06rf8azH3PUir+r3RiQa2HS08rdV4oWjGAMtYI0TBsgc/LqpCu
   RQGQYdoHuCzsUaZY843kQhyd95SgWIbgnyAbZ3zN/djxsXJi7ZPOulk1O
   g==;
X-CSE-ConnectionGUID: YaFLqf7iSEK6c5U31HOQ8Q==
X-CSE-MsgGUID: AkftRHJ6Q62KhVHa4wSgXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="51203714"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="51203714"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 16:36:41 -0800
X-CSE-ConnectionGUID: 4SiKmAgwTHagGzGPZqa0Rw==
X-CSE-MsgGUID: uC8Yq+TaSwu71jDVRm4sQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="94125613"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 16:36:42 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 16:36:40 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 16:36:40 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 16:36:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v58apw79VNUSfoEoOJnqffLQUriRx611rMCLyAgtJrCMn0O+oDdPAxZlk1t0dWkXutcJlpevzbDfEAWfzH6ZpaEqZGv1VJA+2TnpxEOtPAjX+wydSZBChC6PgAeJ+fiGGYQXlpaPF8ds5o1Lx8lq9m858Sp1R9H2PEObwRVrwvUuCckmkokoxAAsUWe62Y30vPsuEMGPDpLszddttBgNpY4P+hORHcdEWq3/2hbprw5zK1XSPRLxZ63A29oV6oimQb9Imb92G6zPz4HYScFl05sauuShf5hKVDwF/uoY758qKXMh4xwy56JH3Oz6+4eZ7AHgPB06+1Q1E2+O/UtWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37MRdudx+kt3XfzJoDXEhsFbJ65Bk2Q0baMukKTgwUg=;
 b=VvgKoybD+E0c9eKfQhJH2B1azv4x61ZRJH7SzIJj/cWjimdOhaagzISvaIFHuxCWNH8M1B+6SfBPCJXKYs3wYJHj2dWyPgFdbr/tLPNZBtixei9roW5ChxXi/7mAcw/9XiO0w1z9o7ScjCtGM8KG7AHo04zTzChL43bXK/q/k3sPrsFVz+9oKoqlwdWOv18eYFfXNUYs8hXrnWQSgSuwlCiSo800aIw65lniKGlpVMvFJy5a1po6fSeArCrFUT9X0aoRUJTZcTofjSKzI4pcTFRGV1B+5GeUJxCl2KBhbZ3qFJWl/cU9vUdT7Wle9Aodit7EYeQfqwbsggD2m26VkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7500.namprd11.prod.outlook.com (2603:10b6:510:275::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 00:36:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 00:36:37 +0000
Date: Thu, 5 Dec 2024 16:36:34 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 03/20] cxl/test: Add Get Supported Features
 mailbox command support
Message-ID: <675247127d82c_2507329496@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-4-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241115212745.869552-4-dave.jiang@intel.com>
X-ClientProxiedBy: MW2PR16CA0070.namprd16.prod.outlook.com
 (2603:10b6:907:1::47) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 506b8663-c3f5-4aca-fad0-08dd158e0ac2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KekO4RtU+9o660i2cH4hDLzr1VID3oHs3ceqniAVFQBq0sKdqQTzgb00Z+KC?=
 =?us-ascii?Q?1B3iI9ZjcSgFFQy+VHvJW7pJW+7BFzewlcZioYsOTz0L8KUqtROjop27WTK+?=
 =?us-ascii?Q?0kAuf00rSTsWnwhlTLlEEZEASVz1/SY1DVpkSJ78Ybq73mYsGtfaBVvSQ6FG?=
 =?us-ascii?Q?rI9K6hQ83iTegGwBzm0q3PfTSfxNDHlK8EOy9Cg2ZaypEen0e2zTU61G2JDp?=
 =?us-ascii?Q?WvwFm3oNcGnkU64WvCnKG/j1ntBPhc3NLjB1VklyYB1Muxp6S+4Rfa9orIHo?=
 =?us-ascii?Q?Y558eE+Ju5fIUyynHeyy3/dLvZHTjLJzykTu50dVXU8MO3YvcKSpd63n0g19?=
 =?us-ascii?Q?hC5Bgsw0Z5ToWcWpdjB1qWeS/4FK6nClKYBe8s1+l3eW+0lYMLCO5FSk66pA?=
 =?us-ascii?Q?3ON1YXd3TXa8DWT84S5CP4qHVI8CO6y5Ilhx5HeB8xl+vY6Vr85pTim/Lkkm?=
 =?us-ascii?Q?W8rkFRZQQ+m0IcF3zY3SFv8uzyLLVWP+I7InvzT+n4kpoBEf10UkQFfyjE6I?=
 =?us-ascii?Q?ztklUvfrKNiytb+S7AdNhYTLe6W9KRE+H9GgL4yNXzDfR7qCzqoS7KQ8/679?=
 =?us-ascii?Q?elSMEoAP9MAY6yZMouv47ZiHzROB1jL1fpU46wmOkTpb0ez5V4A3LIQkd4ei?=
 =?us-ascii?Q?w3HOw8npddrj28oPBW4q3UYqATGdAwdPQ/CYcQUuYnFPVDIUoX2nfzRey7AO?=
 =?us-ascii?Q?A+pmtx+XpPF5PX3i5d+Ncu4ybyeE8apqD6HfRKuMgGsdCIIJ8SlPCI7ZDEMa?=
 =?us-ascii?Q?62CxSrmiIsQh9Zb41LWAvW/x8CJcJijjuWhqtUPCrYgA4J+cOWRPkNU/FGzB?=
 =?us-ascii?Q?JEUD1vGhWJL+g9aGeUhbDmFzJUsTMFZBbkvf/AlzIEM3LLJH3WUmVVUCoa2x?=
 =?us-ascii?Q?jZYjDgQMo1QA+Y7GGFC9bbyb3XDwVKhF9kAkcKFgvYPOc9fu1SJ/yKTncloC?=
 =?us-ascii?Q?th+qUiwNwK0az1Ktr5NMybcLyMuVE7J9jQCThawpxOt9oLB6UOZLxVB0GsBf?=
 =?us-ascii?Q?QPrjM488aTlTp63O5we9hkCyErOpv73uI96L8Iaf+2RunaIgN713JN57IZfn?=
 =?us-ascii?Q?z+931kdOjnQGGKIdjitagN9EU2CuIDLK3zLbiHkqN4eO8oROE9vKTqOVmHUS?=
 =?us-ascii?Q?oFxSobT/9y7SXF9HrihC+Fiau1anI7D+VYc6C6GvLKTldZvEcqy3achrdxmx?=
 =?us-ascii?Q?i3vGTniMs7kBBmau2s5gJP7qvtE+ObxUQ0jf39I5LBMNImDAofuYgabaEnrr?=
 =?us-ascii?Q?2bzLZHmGdSIZ34rMB5KS2Dpc8UoHL+CK6XR/M9CU4FHiwKiv1Qp2yTOJC9q4?=
 =?us-ascii?Q?C2fOHSxlpZy+1sH79I2qRF4UvPcz0vmkTRnHLGMd4fn18w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FXUPLve1DFtffSYXPSzlIZx6kA+HhigEvRrwcvrAEAc/BClK3f7aMBxx/LPD?=
 =?us-ascii?Q?tTr/b1FSR8QZiK+q1VJxiEobbNm5aGBDSV2MsBXMIg4nGqJ1g0lvQ+Wu8cLa?=
 =?us-ascii?Q?dE2SXOC/FRk35GWPbf0aF+07Hr5ctCwuvBV4Q/poLGbOTzY59Y8sLwxidDAQ?=
 =?us-ascii?Q?uiX7mhhGi2U/ICpbLINB0xHxckMAIZQkdMQp9nQm+Am6L1+sx362g4c9YPx1?=
 =?us-ascii?Q?05n1f+vf7+pl7Nd9f6o+H60Q11zHscUANdXRqPNyaVs0FGw0LOPwwsaV3b1t?=
 =?us-ascii?Q?EppXiNrKJyK5kHQnCxVRKrd4aiyrwz0dsHSaOf6/43JhF7Gu0ZtLDPMwz/C0?=
 =?us-ascii?Q?majNkCIpDspKwj2IN+v40Dm5qkSktqlQ83UilC+Zy3rujMIBHEMu96av9ZQ7?=
 =?us-ascii?Q?I6I/lUNsYaXdEbAcfpwNSAgWtLTl8Hcpy/XS3ylwmHqOhNcYfjWU2m5OE4r1?=
 =?us-ascii?Q?dkIeHQM4tB2cIKTYsFzEktpqqGKpGeNlQcUOT8GgF/HPX68+QMxdcGibsHdq?=
 =?us-ascii?Q?PU7kqpWOr5KppDSzYoJetSAhNchjJ5nonoeM6MoMxK6kmithcL6NA7iAREqD?=
 =?us-ascii?Q?43AokezqV1iHx4dZ+949PF1KOVv+a6JO0IcMtrH0w6dEURdVs+4znOLAZPnF?=
 =?us-ascii?Q?hZg8KOKWBm+Q1JuTEeOF0gi3INKRuE8ja0mpHHn17sScuF3bn4QgcvRbAs9H?=
 =?us-ascii?Q?DSWu+q5DTq2DG1/ZH08eXjg3tPtqwaPuf/HJ2avcIyOcUb7sVj/2aefFIt6E?=
 =?us-ascii?Q?BX/gEOHxa6Q2+mz62LL+clD/niBUdCQdARwcV4sT0HKDroH4VEtYW94QdiAn?=
 =?us-ascii?Q?9nTfXvrrQEpc/l4MQ0d6A5IMIIlL4C8TXU9NlwZNJ8ab+whlJBZejBAnyR0v?=
 =?us-ascii?Q?f9s14BKSCtG2oc4s33omJwkb+GpS2VN+k0nthWohw/mWbdOVho93SLHDxI0l?=
 =?us-ascii?Q?z4FyeMr+IqyE4uxTPrdpmxcyJ+w/8Ra6vWFVYRzqKXwaoY3kDnXBPCoh7nsZ?=
 =?us-ascii?Q?vQTRAAYLrpax73Ws7IuBFuTYo1Mb8D6jDmht0WUlYnKwe6E13Lj/ZR+lCzij?=
 =?us-ascii?Q?slfmDZpAyfyzufpdOPeN1GrTpbHMGhC2Hd0yHToTFdS0jDhPQmqyrK4X2gNh?=
 =?us-ascii?Q?W4YL/eLybD5Aj3kSTsbaHqWnuO4eoo+WghwsHjXhCpitC97AezN7nNeaXBEb?=
 =?us-ascii?Q?aSKDY7LR4+JlDuzr5o0yb49p+Jw0vzFo0oXww6uZi89YE9keIz3fAHNhAAY6?=
 =?us-ascii?Q?REv+ZyHf9VcYJ3TWUzilttt03cWe3tfULck+h2Dx6e+tOAgUQmRLgZASw1uC?=
 =?us-ascii?Q?rhw79xOPzp+2MuOFmWnNksAS07lrxfFZfoLzldgz+nmnfHAISLMsDF8oISrI?=
 =?us-ascii?Q?37fT2cUcGV5iWzNzyoLgohw5iOMc/HZyZWC+KYxKXXehok8rqgawJZDu36BR?=
 =?us-ascii?Q?o9vgtfkfPfsgxEU+kzARuMXQ9DfKfNBOQst2wGvPkGsWskQF02CSFzHgRU6U?=
 =?us-ascii?Q?5/U7XL68e68jfBe9dZLAjpmWvQYn4FZeccBIGuoVUKO4XY3XAnKfkHRE6IBT?=
 =?us-ascii?Q?Es4j5eRdQ5knQcSxDAHQIiAZFk0ivsi4eMBXtLwI2ByQSRcUwRzgiq1Wyyp4?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 506b8663-c3f5-4aca-fad0-08dd158e0ac2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 00:36:37.1705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6h8Gr8BlLdoVMnqT9Bkavtu4xGY/ajz67cihx28omyi/2voBovttP4ECXXDnSqbWKiCsQWLmECywAvht/iWAIgy+1HVXeqK9Tvn7zGIHJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7500
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add cxl-test emulation of Get Supported Features mailbox command.
> Currently only adding a test feature with feature identifier of
> all f's for testing.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tools/testing/cxl/test/mem.c | 69 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)

Looks good to me:

Acked-by: Dan Williams <dan.j.williams@intel.com>

I explicitly only ack this because the real review is when the
corresponding test in cxl-cli is available, but this can go upstream in
the meantime.
