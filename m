Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B7D1859
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQPwsa96"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E88DE
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 14:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698097673; x=1729633673;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NmMGsT9rNlyVMyMvLSPNBKetx4jfxJklYOogePNvpH4=;
  b=WQPwsa96MpxhwE4NZvyS2aNu2H1hFyo9jYXwGHzD6l/vx65FkIQB8tFy
   2jluBjSUEfb1MPQEhJ3Wm7a4pzarCQcH4Ez72+IoRRkcFjQ2FfR+VxebY
   sGItVPgFXo6W0iuA4c/FwypyuRecU66QMH5y1ecdeFfp9PpQzgqexx/SP
   NoQDgyd+NLbhKrWSlFeWy0KsAd6qq47Fd15V+HBMhrpBoV8QuBEEoBYs3
   E03lGik8LgVjmFCPlKbyRpx5Av7SAe1WaD/JAzvtA+eLyfcuxrx87045B
   CmUb0loHYIlP2+tnZ8dYZ9L7ta5WwFNRjyfn9eX9DD23c2ui35emW+6NK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="384135104"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="384135104"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 14:47:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="828586530"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="828586530"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 14:47:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 14:47:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 14:47:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 14:47:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2ZwEQ4UQrPkhaIAV/3OTNqlAZX7978DrBwWN79PwGhjC742MWSXbW36t6gHFBL/tSnzys5GvWCSmwZxZ61dTemzJ0RCNhhiKzfQvi3HbsZPp/xuAAbX3xn/Ms/VrcmP1Tr7Cuv2v8t1NJwPA6PdIf+V0yk7SINuYsVrotfXLFWvlPG9H0JANT2uTwAZedy1wlfRFjN9vtPkoaFSJwkH8mYoqcTpFlTgpCxZB0P4Pq30729V8gubwN25gNKF5WLf+w2sdZC0eeFXH5LtGoPYwdBWB8h6XHn/XcR9BRNw+1KQGilhwg/R68yXJm7EVXB4Hm+9f1rzCVA2JRWPe4iFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyFKHqpTHz1ZyltkPXlOYGvtVQWHr9iLL3nziQ8zYQg=;
 b=Og5wdM689eDsYeDJ9OgITMidfIZYPl9oz4FwtDG0UMtmjlZDabof9m1/WU3ONW9Nb1c6GvWKlf8kJbnFtkVbpVTddR70bV6Ix7INCYOB5xtnNcq/6lW48S/GDCAOBx/x8x8v0UAsCukiZ9A4nebRYTxKXpb2ptWTmAFqgkAkKdgwsHb9t4MuNqcU2A21tQLQ4Z8CtZ82Tc0ZK585itFg4u30no4hkuFdDYAcE1lmXPdQsfQ7MhrMZG4juUj0ZXSRRaVvkHF9AiEd1YmTxAEQMWxVY485zcfL6hVAf4UTx6Yj6V1seSBMIMBXS+3gZN0sKwGmr4sujMN2L53c9qQlew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by CY8PR11MB7361.namprd11.prod.outlook.com (2603:10b6:930:84::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 23 Oct
 2023 21:47:50 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::8dbc:889d:7f9a:e7a5]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::8dbc:889d:7f9a:e7a5%5]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 21:47:50 +0000
Date: Mon, 23 Oct 2023 14:47:47 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dmytro Adamenko <dmytro.adamenko@intel.com>
Subject: RE: [PATCH v2 2/3] cxl/region: Calculate a target position in a
 region interleave
Message-ID: <6536ea02ed6ad_725832944b@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1697433770.git.alison.schofield@intel.com>
 <80f80f0d26e73cd6941d8530163a4bbd731d50ec.1697433770.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <80f80f0d26e73cd6941d8530163a4bbd731d50ec.1697433770.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0219.namprd04.prod.outlook.com
 (2603:10b6:303:87::14) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|CY8PR11MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc8a0cf-02a7-448f-9cb9-08dbd411b3de
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qw9DEP+JVzynNjd4O6R5PKiLjmYU3gn3FYFYEUeUiwHMegoXjRHHSTG27vcNvIcWRGEZIcSdnEdqFqA6UpfYh+OAFtXJbPZGVOcA4SzziyBT93WMqhOjFpz7rZlxsJpOegIGpnpDAa5DVM3bB3MtDpSkOTNcf1gKuu+rHr/8HZPmXHO2zb7+Lx8CvZY24troqY9ESqmCVQHMeR8fiFeiO1FtVV72a9/x5SaCZoCb8ONSfdIDepDxyLYOdWpihVLIDLwvu2nD1NkS9Sxy+C6NZRfOBsCWdFGATi4QKCQb3ew9xdqYzoPRnYcEmICGs6MHfdL4kFA9RrtJbGMWA7liN/vwlPqRfeXAsQiMPY7qVRaoeXmZVn41IfqK9QzS3EHfqwpTTUszhroxwt+9wYxfU4En53e0guoHPqS92GC/2s9C5UvQZZQg6XWngCgERa6bEljOXjwDh9i0OMxuYKl5Um2RjcItLvhP/z23TY/37dlBc1YjR4QD/IwASNOl0r4FK8mt1Bjo5nGsVEr5EEwapsV80WGPu2FD6gjIf5iOfAYMmA0n5oiR6+5W7nJtvAam
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66476007)(41300700001)(66946007)(38100700002)(110136005)(2906002)(86362001)(82960400001)(66899024)(66556008)(316002)(8676002)(4326008)(6486002)(8936002)(5660300002)(6666004)(9686003)(6512007)(6506007)(26005)(83380400001)(107886003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Ode9eeNjNfsrk1NtMmdYYaXqLvpc3nNrobzbibR61uE/sWLDbKwa2hVY49a?=
 =?us-ascii?Q?eJVKBQHt7hC1pzsmT9X95qfPCCW2b2kR7F24/bf6SMRKidMfmYBQ4h8azZHx?=
 =?us-ascii?Q?jbjkMQ+/pMuQYCnRqq6c59rAGuZ65bCTRdJ+Nut7sGgWTDTAObo+K8fwzSIe?=
 =?us-ascii?Q?lilFlSP6dsKSz+Jipmtkt4jT4T3x3wU7Q3W0nlsZ0XnzhrE7f5pbWp82a3JT?=
 =?us-ascii?Q?KFRpWynxMFI3ECAc5Q2jH663aymzqTJtJlDRCV5hiHit0zsAD/3sO37/sanU?=
 =?us-ascii?Q?sPEgF5hfilIpjIFbCLCHydAWtahwIC5BfVIGbK2HyXXG2UXnAXCj4L3vjZOa?=
 =?us-ascii?Q?fX3dBuY+w0gnRMf8XCbFZcPlqVXQ94qbINxvE1JaPOBFDzavdCixtlGwkKhM?=
 =?us-ascii?Q?M6MkARFs3+LmBBgdDqDqukR08y2oCR5D+A0NIKQiPQTTxWsvy/0ayKJ0XIB3?=
 =?us-ascii?Q?5B+y+0/QfU6cbsykqV4GSJFnDZNkNw8jgYVoFXuRfNclt1tKsG0GSGGQFTPc?=
 =?us-ascii?Q?Usg/F53tSyP3FdeC9qVz6mIz2jPlTRBnvaOu0HOiPlwbhQbUKXrN0ZHr7yWQ?=
 =?us-ascii?Q?/L4Eyc8OPXLfUE0AB1m3wfYe50xKP/0G5XAFFkTiqHgRdYc0PierYER70jZ1?=
 =?us-ascii?Q?qiNreeAowq4AcUSaFo1zvYZBAoxeaxgxGd989UBhl8WS8ofWX9imFe6rcIUX?=
 =?us-ascii?Q?qbqWtOgFqbsUwrLfg26Xwhjp0D4KsbZ4DU4K7F2kLOD26Jv71QK5GBe0y3xe?=
 =?us-ascii?Q?N70xkCM5Xh+YVtKtBTqgmmjvzRB5Lecy3HGWjPgWA2HJ9ceC/wBeOdBKa/nH?=
 =?us-ascii?Q?MID4gbtMjgl1GKA+6Mawev/HN9/u7fudpPwVzCnTP3mlfrlazEiD9l0XC3uL?=
 =?us-ascii?Q?Nr+1mF0EuJGTl3EuozNn1pxvloX2z2ulH0RLuGRqDUZ6SwrhIMcA9Ah1o5hQ?=
 =?us-ascii?Q?yKkrg2eE9wxq/2P+tp5VrEYbm/yuPh3+bwlvhjEGYlGvYpGf0PlfU50WuF4b?=
 =?us-ascii?Q?25npAYQC4bkScMZ05LwWXgwxqm+3CVkyLjRHMi/zXSJI03O0+hA9ij7axHCs?=
 =?us-ascii?Q?IKXw0jP4oeDfMYXoVAWt+LA/30krSUutbB1NJsWKs2uBRclI+6/v7xrViZNN?=
 =?us-ascii?Q?Ivoz4kSzbVn56pa04O67gIwXqU/5q9nJ+WhxjJ2TOxIAzHokKGrrc9rBbMAf?=
 =?us-ascii?Q?d9yUi84BjHtVV29d8dc6zoxwgMKdb6S2Qv4+etRlepq6Co0priVLmfnbOfvw?=
 =?us-ascii?Q?+1rbnlrc6SA0wqqYOnAVfzJNVdkb94sYqMn/fbCWMTj8QARLhPsxyIyCwk0k?=
 =?us-ascii?Q?G09YCE5MzwP9Udef0I3D3iAs883tUR6jsYRx2or67LKuVFUKZBh3fWCBzPGn?=
 =?us-ascii?Q?OBzSZxb2UtkaHH78/T2t/OFvaeg90oSF2jyNrykC2CELKKCYuyQMUF/r/L27?=
 =?us-ascii?Q?5/aSlX/tt3CrLsU/6JkK8MNK5V4k20YW6aEDx7Dnq3d8u9iNX6jzU/NFKzYT?=
 =?us-ascii?Q?CnroRTtRO6BhNsIogUiv0ITUiVhbUxNG6Jf74vjA7GuQX8063Y5DyDpwinaF?=
 =?us-ascii?Q?ZneZjkLer3q/0XWC6+URxbQZrtvITcn6Qf/CEUaIV7tkYBTegdwZ9OH6DEsv?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc8a0cf-02a7-448f-9cb9-08dbd411b3de
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 21:47:50.1919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x44AGotAhPzoUJJwdvGka+cura2V7gshyHmgcm8Ybu3LH8XimVwuz38DcZeKdVYSyinKRqA5uwvKcO8JZrDp9a7/nhhfLdaHKWNTrvduumI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7361
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Introduce a calculation that determines a targets position in a region
> interleave. Perform a selftest of the calculation on user-defined
> regions.
> 
> The region driver uses the kernel sort() function to put region
> targets in relative order. Positions are assigned based on each
> targets index in that sorted list. That relative sort doesn't
> consider the offset of a port into its parent port which causes
> some auto-discovered regions to fail creation. In one failure case,
> a 2 + 2 config (2 host bridges each with 2 endpoints), the sort
> puts all the targets of one port ahead of another port when they
> were expected to be interleaved.
> 
> In preparation for repairing the autodiscovery region assembly,
> introduce a new method for discovering a target position in the
> region interleave.
> 
> cxl_interleave_pos() offers a method to determine a targets position
> by ascending from an endpoint to a root decoder. The calculation starts
> with the endpoints local position and its position in its parents port.
> It traverses towards the root decoder and examines both position and
> ways in order to allow the position to be refined all the way to the
> root decoder.
> 
> This calculation, applied iteratively, yields the correct position:
> 
> position = position * parent_ways + parent_pos;
> 
> ...with these rules:
> 
> Rule #1 - When (parent_ways == region_ways), Stop!
> 	  position = parent_position;
> 	  This rule is applied in calc_interleave_pos()
> 
> Rule #2 - Skip over siblings that come before this memdev in
> 	  the decoder list when searching for the parent position.
> 	  This rule is applied in the helper find_pos_and_ways().


I feel like calc_interleave_pos() is missing some kernel-doc about these
rules. It seems fundamental to maintaining this code going forward. This
short summary here is sufficient for the changelog, but
calc_interleave_pos() wants a few sentences on the theory of operation.

> 
> Include a selftest that exercises this new position calculation against
> every successfully configured user-defined region.
> 
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")

Again, this change is not a fix, it's a new diagnostic. It is a
dependency for a fix, but that discussion will come out around
backporting patch3.

> Reported-by: Dmytro Adamenko <dmytro.adamenko@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 102 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 64206fc4d99b..b451d215c3c5 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1500,6 +1500,93 @@ static int match_switch_decoder_by_range(struct device *dev, void *data)
>  	return range_contains(r1, r2);
>  }
>  
> +/* Find the position of a port in it's parent and the parents ways */
> +static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> +			     int *pos, int *ways)
> +{
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_port *parent;
> +	int child_ways = *ways;
> +	int child_pos = *pos;
> +	struct device *dev;
> +	int skip = 0;
> +	int rc = -1;

On the risk of this error code leaking higher, I think it should be
initialized to -ENXIO directly, and not translated by the caller.

> +
> +	parent = next_port(port);
> +	if (!parent)
> +		return rc;
> +
> +	dev = device_find_child(&parent->dev, range,
> +				match_switch_decoder_by_range);
> +	if (!dev) {
> +		dev_err(port->uport_dev,
> +			"failed to find decoder mapping %#llx-%#llx\n",
> +			range->start, range->end);
> +		return rc;
> +	}
> +	cxlsd = to_cxl_switch_decoder(dev);
> +	*ways = cxlsd->cxld.interleave_ways;
> +
> +	/* Skip over this many siblings in the target list */
> +	if (*ways > child_ways)
> +		skip = child_pos;

Maybe a clarification that "Since the switch target list is by
definition sorted in region position order, siblings to skip are always
at lower indices."

> +
> +	for (int i = 0; i < *ways; i++) {
> +		if (cxlsd->target[i] == port->parent_dport) {
> +			if (skip--)
> +				continue;
> +			*pos = i;
> +			rc = 0;
> +			break;
> +		}
> +	}
> +	put_device(dev);
> +
> +	return rc;
> +}
> +
> +static int calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> +			       int region_ways)
> +{
> +	struct cxl_port *iter, *port = cxled_to_port(cxled);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct range *range = &cxled->cxld.hpa_range;
> +	int parent_ways = 0;
> +	int parent_pos = 0;
> +	int rc, pos;
> +
> +	/* Initialize pos to its local position */
> +	rc = find_pos_and_ways(port, range, &parent_pos, &parent_ways);
> +	if (rc)
> +		return -ENXIO; 

per above, this can become "return rc;".

I had wondered if this code becomes easier to read to have separate
inputs and outputs versus dual purpose the @pos and @ways paramters, but
I can't come up with anything simpler. I think a bit of kernel-doc would
help with the next casual reader that comes along and wonders about the
theory of operation.

> +
> +	pos = parent_pos;
> +
> +	if (parent_ways == region_ways)
> +		goto out;
> +
> +	/* Iterate up the ancestral tree refining the position */
> +	for (iter = next_port(port); iter; iter = next_port(iter)) {
> +		if (is_cxl_root(iter))
> +			break;
> +
> +		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
> +		if (rc)
> +			return -ENXIO;
> +
> +		if (parent_ways == region_ways) {
> +			pos = parent_pos;
> +			break;
> +		}
> +		pos = pos * parent_ways + parent_pos;

Nice simplification of the current mess!

> +	}
> +out:
> +	dev_dbg(&cxlmd->dev,
> +		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
> +		dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
> +		dev_name(&port->dev), range->start, range->end, pos);
> +
> +	return pos;
>  }
>  
>  static void find_positions(const struct cxl_switch_decoder *cxlsd,
> @@ -1765,6 +1852,21 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		.end = p->res->end,
>  	};
>  
> +	if (p->nr_targets != p->interleave_ways)
> +		return 0;
> +
> +	/* Exercise position calculator on user-defined regions */
> +	for (int i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +		int test_pos;
> +
> +		test_pos = calc_interleave_pos(cxled, p->interleave_ways);
> +		dev_dbg(&cxled->cxld.dev,
> +			"Interleave calc match %s test_pos:%d cxled->pos:%d\n",
> +			(test_pos == cxled->pos) ? "Success" : "Fail",
> +			test_pos, cxled->pos);

Part of me wondered if the failure case should be louder here, but in
the case of autodiscovery there is no position to compare against.
