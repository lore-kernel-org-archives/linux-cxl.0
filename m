Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i5Ox7JOE"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B84E9
	for <linux-cxl@vger.kernel.org>; Wed,  6 Dec 2023 20:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701923954; x=1733459954;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tZejcXIcbxEzvt0BDwWvvcuzmzAtMi3OohKlBpurB6I=;
  b=i5Ox7JOEUJy29Fu8MuE0gI4ftKAoL+s9683RJKbirBILu+3wD8iPDplG
   x0yB5f0aQQEQsOcoz77sh5W0PjaqrdU6C/JIr7w5zhZxSoDrvd25uKuS3
   qDI87rYqy0V2X0NA6agPMbI1UJoG9ebNQ6klp62UOxS63wvnb/h/DRAtG
   5BYSICeooSl1IU+DsA1rgK7UDrTGF+CtN2DQB+Et1mz/HRMcymnLNtvb4
   Q0dz6uClUsrrffJoTmbD3ssVQ/q7gpqemD0aHz47+iSvoeBXpQCLJ/3jX
   rDebBOvC26VZcilQnJrdXlA7gJhhf3E7Q+xvpU/ZwsR1JUrCi30IO0qB8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="379190830"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="379190830"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 20:39:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="805874512"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="805874512"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 20:39:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 20:39:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 20:39:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 20:39:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 20:39:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/7qqVscLSF043Ka7H8h/BvzFCQwZJpM9xidfFtp/SSq4/WJt3sZNUaZGqCu1N3TNnD4SyI9nBhWgPscTacuDDLSct7O9GbMU4//6zCqxPf4nniV9KS3jtl+F8C5xjdobazzVMFPG49K3ZPhGVkjm0iIPtFNUD+KiJ/wCTARi16/My8NB4taUmrkNw8T/NymQpjK9qo5tLfBljRjVI6WHRm71aHUVoK4qV5dGCHdHrL6Gi7NnnPYvZ33U4ZecT5lmJcHnbtNGbvqDch1Q2vYIT0rfO0ErF7ecMjTrRcq6K2Jvi6sxxxAYpm4bbYsFnODkJpimPs22959Pbz+ejYbuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hge+4UYbl4LPNm+UbCJ076E9kPZA/F+2Xy6zv0TaUp8=;
 b=Ax/mFh/YSlE8kuwAz8zGyoi2o+DEtnL8KK6EwF5d4Au1eMP3WULXo2q8i6Nn8Qgth2XyHr5ZADKng5s9vMlOyitRFSl7iDZF0QICcsenMVnbspxzTKKLmRHi3zqP6bY3xW63xDaO+uGPABcg7kpCiWD/k/5EA+qJiqKy2T+JYn70wlDzr+m4lMFqq/UXkAauMbQJkalxMzH2mUhBim5VNludiquli9Yu2URxqQOgfizAoSe3ZG91YNJ/o7atUYMQmxfkyHfph4fq7lXSaa0zAm+8aAhDNSaveczoRQrRbwUeSh3kWmUOzjZlbQkie3yL8lilJSJCi2NpLWgiIXa1uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB8284.namprd11.prod.outlook.com (2603:10b6:806:268::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 04:39:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 04:39:09 +0000
Date: Wed, 6 Dec 2023 20:39:07 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
CC: Alison Schofield <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [ndctl PATCH v5 3/5] cxl/list: collect and parse the poison list
 records
Message-ID: <65714c6b472ee_269bd29417@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1700615159.git.alison.schofield@intel.com>
 <bf65d11d6388bcdce2e6dc35064edf4094c0c5a8.1700615159.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bf65d11d6388bcdce2e6dc35064edf4094c0c5a8.1700615159.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:303:8c::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c953ee-e094-454f-e36f-08dbf6de742a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6rPoaQES1DSs2ghbVjMkqWVhnl4rRCOOTuyHoxsM5BzBBvmX5nuGncqT/TZyKhpVjV/xSebty8a4kWgRwRaZb6GUe8Xwn/bDmPCTU0BrTiBJ91gbQ2Vf3hfNfEqioZHgwkz/fY4Y2gsUBUnLPnVQvVtu0C4rK8YgUYPvNoMJSJL5FSgpOiz5Ba4S//0imtRlBYXg5ZRPu9Y8LsLi2GuQe1gZFLKzdkHg/I8Dxtk1IAVNSjvNoEakhvWl2GvGED2UxB+jO4Y6dXqeDZqRucPoX85aWySb0TLyrJ+bkcbjL8dTfeGe/aNNDa+nBwUlIId4XBAhmd8WKFI9+fS41CQFzWF7eFvln1FtOb3YKihbpIE7lhAdzndgMMQ0qMr+/8cSeptmfCQ2BrQXTRh7Cq/GDu3koNYwwBeO1qPhM6sHiRh1dEG/GDW9e3A6Vt+05dHbjSf/3ahdkaM+wAfuDm/bjCEVJjEYEKcFeF9d6okmkWyOkH425ugwClsJp/BEdFut+4n8lEpWCwINwS8+IN3EL4WfAfxe3aRWe34YafLPRuymcxgYnAJAgQHGGC2IP1+4X3JnRwV/StV1JSs2i//yRgsjtb15Z99A51ooAJhTYF3xQIYNeljD83Zrl5WGmDi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(1800799012)(186009)(316002)(66946007)(66556008)(66476007)(6636002)(6506007)(9686003)(6512007)(41300700001)(26005)(478600001)(6486002)(38100700002)(86362001)(82960400001)(83380400001)(2906002)(5660300002)(8936002)(6862004)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H9pfqWG52/ppUg/wdEDBL63yIIKmM7I81nlMPlqD160SNwvVv4uKv3iS+Ae4?=
 =?us-ascii?Q?8IQ5PV5II8+X/gwr66gkNNbQH+E9A1BDED99z9WNOEAs9r6hI6FEWi0RKZjB?=
 =?us-ascii?Q?0frZChCda/2B5CW4M5uNBUK+oyT5g6GlI01awQHVAOURxIV4RNAjval7hTEW?=
 =?us-ascii?Q?676U/hm4YE+86cQE5MP1vQNQXQSDEuOUHdIRuVdK7+9m+oGWTqaOdoz/7vnU?=
 =?us-ascii?Q?jotq5ETn5kZhqrYsHjZmG1XGgqiUkMVq071iZf7KPxy78l/VGPqUBqvzuNc0?=
 =?us-ascii?Q?gI2bF6i7OXeEQWNfTinciCliK6bYHq2uT4HoIpEtJGdr4iggAamqUGHymjnC?=
 =?us-ascii?Q?+4Zu/v0knuvuB9oTVg95yCnw9JB6pt0ZmWjOsSHqn4zSM0BQK6vfBwe2HuDi?=
 =?us-ascii?Q?5KplEi28wLYLINcpsIuP5k1cDA/TmGEBdLtvJGvu4JmFvnvyWg1qnDDiZROr?=
 =?us-ascii?Q?KJ9M5Jm0ozYjGCa/kpn3uewDliTnj82vGKFJYLXhNIetGOW3f2t6j3tAArOz?=
 =?us-ascii?Q?rJNrj8pS4b/ypvhbQQTqkKgImmLUOCuQCXiwDU0zBJKkH7c66v2BW54y/JHZ?=
 =?us-ascii?Q?5TBa8OJqTg7d822X+tAj0U6FpCxgodbw0+H9+HeF9MasvMDdWtyYxKO673am?=
 =?us-ascii?Q?6vCVgPI9LvHkTC3REHRMG5iUCYcNPt6nvv8noHvMbgy/S0+spObAWmD2urzi?=
 =?us-ascii?Q?fBegpE1PswwaVj+0YLhq3GOvOIf1ymYTAVRDAEEW9RppxFgIR+NF7ZA9wzh3?=
 =?us-ascii?Q?uPHsrB3Wp7+CpO2wglDa7wIbElJK0VJOpRinEYdB5Sw94u6jqNSN460PZTUq?=
 =?us-ascii?Q?zx+VtPhpX10WRCJ+v6Wzqb3qokQ1QbwEfb/kdLINHHkL8ACeGBy4i0eFGFLR?=
 =?us-ascii?Q?j2HYFcLfLebHJQS6vmTmUXk2AXb2scncZ7IkM7Wsr4myZPTtcttq/oyLuFcl?=
 =?us-ascii?Q?4nIIfkBCoTuUQPAm3jjmKLI/fe5IwqLX9XIC9EpDWkZM2DgNxjppiIYAf89S?=
 =?us-ascii?Q?l9uxR0BlPvyDNo1EpiILI2qBYmSakRP4eTJhZA6CXm/csbT4nJhTrZBc4B2T?=
 =?us-ascii?Q?Ukqp5Fb8n2BsdrabE/eJUGNGP9D0oNjnckjuDmVLQubKsJqVaixSGzTzLv0z?=
 =?us-ascii?Q?GWJXMBrhfAMH2fJ4UInu0Cm+huR+ypVPxz9ySk1ATg2ZmYzwedzczm8WBrm7?=
 =?us-ascii?Q?cMH8jpvkjMqqd4Uc5aHqwfbaX4qOnqn7/NxQJpEHIlJYanId8wQavmbUFrM1?=
 =?us-ascii?Q?A9/JzSJavDIySQh62kp51ByGi3qOqZ7YrwI74spP2at7rS86PVSlRPFhYLOl?=
 =?us-ascii?Q?Oc9JX81Pds+DpWX8GFaoXvei/DeWnE1v6znaDK7Yvr5ZXEI+1qMlk/B3F7hM?=
 =?us-ascii?Q?pNj0H4n3JDyGJuR7QCyu1q/+Ihagc7j8wxMU1uywAYZf8Pv4clQ6kxesxhGH?=
 =?us-ascii?Q?ykRr9xfRfdH8DvYo902GZK24azI354xRvXSIkLSwWKZQSM9t9wjwRJCh/gsG?=
 =?us-ascii?Q?GXRkyoMOCSl879hay20QbKoI42egnxSjf2s+gJwHm+qZst0AkMJKh2pYjcCN?=
 =?us-ascii?Q?dcmaJoF5tzSjGky3AQh1JT0/TFEKz91OuZsnAeXtujAgDAN99KfCe9VGQOI7?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c953ee-e094-454f-e36f-08dbf6de742a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 04:39:09.6577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oL3DvA82wRoh29xNP38KB/Q18/NadFzYVnTe4E/YllAUrkPavJiKiydSJqFnmzpwdYe6J+mNJAHLW733DivvK4UUiOkm9PBrbbZjk6f7sY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8284
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Poison list records are logged as events in the kernel tracing
> subsystem. To prepare the poison list for cxl list, enable tracing,
> trigger the poison list read, and parse the generated cxl_poison
> events into a json representation.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  cxl/json.c | 211 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 211 insertions(+)
> 
> diff --git a/cxl/json.c b/cxl/json.c
> index 7678d02020b6..6fb17582a1cb 100644
> --- a/cxl/json.c
> +++ b/cxl/json.c
> @@ -2,15 +2,19 @@
>  // Copyright (C) 2015-2021 Intel Corporation. All rights reserved.
>  #include <limits.h>
>  #include <util/json.h>
> +#include <util/bitmap.h>
>  #include <uuid/uuid.h>
>  #include <cxl/libcxl.h>
>  #include <json-c/json.h>
>  #include <json-c/printbuf.h>
>  #include <ccan/short_types/short_types.h>
> +#include <traceevent/event-parse.h>
> +#include <tracefs/tracefs.h>
>  
>  #include "filter.h"
>  #include "json.h"
>  #include "../daxctl/json.h"
> +#include "event_trace.h"
>  
>  #define CXL_FW_VERSION_STR_LEN	16
>  #define CXL_FW_MAX_SLOTS	4
> @@ -571,6 +575,201 @@ err_jobj:
>  	return NULL;
>  }
>  
> +/* CXL Spec 3.1 Table 8-140 Media Error Record */
> +#define CXL_POISON_SOURCE_UNKNOWN 0
> +#define CXL_POISON_SOURCE_EXTERNAL 1
> +#define CXL_POISON_SOURCE_INTERNAL 2
> +#define CXL_POISON_SOURCE_INJECTED 3
> +#define CXL_POISON_SOURCE_VENDOR 7
> +
> +/* CXL Spec 3.1 Table 8-139 Get Poison List Output Payload */
> +#define CXL_POISON_FLAG_MORE BIT(0)
> +#define CXL_POISON_FLAG_OVERFLOW BIT(1)
> +#define CXL_POISON_FLAG_SCANNING BIT(2)
> +
> +static struct json_object *
> +util_cxl_poison_events_to_json(struct tracefs_instance *inst,
> +			       const char *region_name, unsigned long flags)
> +{
> +	struct json_object *jerrors, *jpoison, *jobj = NULL;
> +	struct jlist_node *jnode, *next;
> +	struct event_ctx ectx = {
> +		.event_name = "cxl_poison",
> +		.event_pid = getpid(),
> +		.system = "cxl",
> +	};
> +	int rc, count = 0;
> +
> +	list_head_init(&ectx.jlist_head);
> +	rc = cxl_parse_events(inst, &ectx);

This pattern really feels like it wants a cxl_for_each_event() -style
helper rather than require the end caller to open code list usage.
Basically cxl_parse_events() is a helper that should stay local to
cxl/monitor.c. This new cxl_for_each_event() would become used
internally by cxl_parse_events() and let
util_cxl_poison_events_to_json() do its own per-event iteration.

> +	if (rc < 0) {
> +		fprintf(stderr, "Failed to parse events: %d\n", rc);
> +		return NULL;
> +	}
> +	/* Add nr_records:0 to json */
> +	if (list_empty(&ectx.jlist_head))
> +		goto out;
> +
> +	jerrors = json_object_new_array();
> +	if (!jerrors)
> +		return NULL;
> +
> +	list_for_each_safe(&ectx.jlist_head, jnode, next, list) {
> +		struct json_object *jp, *jval;
> +		int source, pflags = 0;
> +		u64 addr, len;
> +
> +		jp = json_object_new_object();
> +		if (!jp)
> +			return NULL;
> +
> +		/* Skip records not in this region when listing by region */
> +		if (json_object_object_get_ex(jnode->jobj, "region", &jval)) {
> +			const char *name;

So we're building a json_object internal to cxl_parse_events() only to
turn around and extract details out of that object that tell us this
event was not of interest, or to create yet another json object?

I think this implementation has a chance to be significantly less
complicated if the event list can be iterated directly without this
temporary json_object parsing.
