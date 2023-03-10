Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39937C6FD1C
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Mar 2023 09:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjCJJqA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Mar 2023 04:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjCJJpo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Mar 2023 04:45:44 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6B6C668
        for <linux-cxl@vger.kernel.org>; Fri, 10 Mar 2023 01:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678441525; x=1709977525;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=3w5sg5PqzALdQQB91rkNWs6W2doCjqiqNS1M0OYemlE=;
  b=kaZL/O5AUFwB/eeq3IyD1QU2uhEQNqi2huA44prjAZYMistdjHn8jwFq
   Aw/Nwjjcf+Z67+p5eqbF8eReqVSNBxMFXgZ4iWis5lEqzuCpVRO3OWDGE
   Tnsa3O8sM0DwG0K8zXo6JeC/4WhCPkDazc8fnYg4lFo8Uv2FRmW/+yuap
   FXm6o8n5QQcZkzZ5rSTP69QOyXIko2e9gSXzV+d0tAxiEFVoPD61W6PBK
   d5APllMHF5sH1vw7Jj5lc3Jxk6BiRgVozzJZzO9rGcm0/kxlmuiQBq23o
   c3m0NPhE5534KJs+ESOSqLgOhxacRfrUqdC5Zia08E/wgNKJ4TR2s37/a
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="401553442"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="401553442"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 01:45:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="655125737"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="655125737"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 10 Mar 2023 01:45:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 01:45:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 01:45:23 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 01:45:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjWWxl8GbIFmdVg2cB1GagLrBq8uwNb3UoBQVkl2caOy6NJWkNaveMoCldWcV7KRU5Sr4VywL8Wkz799l6hQmfDwdyW9wZAXGq/Tbm0tM+vm1KdDS0NrwyCGnfQH7eolYumDEmRVzg1434+bXvulHMmKvu6klGCRQmhwd0DF6tbU6b0Bf4SgQS0XMoYpUuLIwCM0zJGOkabbbINHWfkwuhJfPSZDn7wYb8N8Q+akYgER36XXdsamRKw1ABWlxhE/sNeSJsh9HRNPnVOTkql4TD+UtNLA69EM7dtEnaztUVQbSzSzdkHuVszhoHI/VLNUUNOVr23bzHxbAOSNsXMGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22hgRdhD7yIg9cvZcUYtaBVwpNuOuqfEU0juwAh2t1k=;
 b=EkvaqkwSU1K1rpIsG/9pqsukEBzsdhK4hWSZ1PRMJV68lSXW93kZjXVNe8L0sTReaf2h0fCDwPNq8Al6hTwKfnaMkYgZWZT1U/0N1HQCTs1syrxiG0ExvsV+5Ot6tFtqXCiGAKymf/4M1Y3pKwwZPbjkrPJ/0KJd/kWkczun8a9t+m3RR7XUuo9kXWbAwvlHU5d5yd3JG1gOoZ7Paww/qVj4PyXPEMJ3T7Ef/tUPdFs/o7mRBq61TBIVGLuLakyNE2G/+qGY0fkoesCgP/g+yiavsSWbrHtuiWRCvIw2GpbHnAhbJwgsJh+uCTtYejxoaj6+1QCbfKDgM9MPftdmlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5155.namprd11.prod.outlook.com (2603:10b6:303:91::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Fri, 10 Mar
 2023 09:45:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 09:45:16 +0000
Date:   Fri, 10 Mar 2023 10:45:08 +0100
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jehoon Park <jehoon.park@samsung.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <bwidawsk@kernel.org>
Subject: Re: [ndctl patch RFC 0/2] add support for IDENTIFY command
Message-ID: <640afc248194_48df72947@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <CGME20230307081917epcas2p1accc8f7bf3f31e08525684abb2efa788@epcas2p1.samsung.com>
 <20230307082102.27195-1-jehoon.park@samsung.com>
 <ZAecHtXUX5ZR9ccU@aschofie-mobl2>
 <20230308090134.GA15397@dell-Precision-7920-Tower>
 <6408d271a2c96_f3f4a2943@iweiny-mobl.notmuch>
 <ZAkE81CNAjXB48Wz@aschofie-mobl2>
 <20230310065454.GA2666@jehoon.park.samsung>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230310065454.GA2666@jehoon.park.samsung>
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5155:EE_
X-MS-Office365-Filtering-Correlation-Id: d46ff171-c593-42a8-a791-08db214c26a1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S4J+VF6JFp9T1ySdBHmyJhBx1uy16ufwIbHN974EIPveAauvrE2+mz5Fo6M4i+DJ4MYeg+K2pw/7EoooRKk9maYM5zIcbkXxpKu8kdoubDR/1zlZgBRBmPbLN+m8axVggjUQuCvwEh4hh80QnGl1iNQQrwRYYBjWDbM4L7TeqDrVlMUM0Fh99HTi9aTbzvKYwMYLxYxwRhI7fyagOObCcN/vUZaxfjl+oLdAMqt4aECKCJx655knE/O+7bPeRGhZMMYLUXtmCOpNoAyzUUlEsS3xmJHMO/RB1wwGxHkb6xTWbye+CaHnVUPJ+SHVIsArA+Kc7SbpoKjayI9Ny5hwvF+f0BE/cXWp5SYCYDlIm8faFFBJfXlS9kf7xtBhUlf0KlBoRVw4qewOo8xk93H8MXjfH3xfinaFlugYUAgJyLMEEWiM87tz8mviApP/17VT1Dy2+pWG6WcOrkuRA7jbDTIyZNy5y79QQYnEhC8LPUSAZs6UEVEaxgnTQ1DvCK3OcEDOjClEouE8IH+aLSoF7JtB7KQh1ZF2ziwdzoAwkQkeWcrTyptkVzX/HMe6S6oTcD2S1QGi6CvAIkVRqM2LOPNwkiwe3O+3xLQwFeD15OjjZioR4kR3+q1bmOUBFkEqQGVsGqY8MyEsYSacgRjH7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199018)(83380400001)(38100700002)(86362001)(82960400001)(66556008)(66476007)(66946007)(8676002)(4326008)(316002)(2906002)(41300700001)(5660300002)(8936002)(26005)(6666004)(6506007)(6512007)(186003)(9686003)(6486002)(110136005)(478600001)(6636002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2pYY1JMWXZDbmQzU05SN1RUUFBoNldsa25ZQkllbHFaUG1vSHk3Z0pPSVBQ?=
 =?utf-8?B?dk05RFlWZ2doZ1BNU0hNLzFJWkpHa2JHNHpnMzNrOHhGN2dnUWF1ekgwNzgv?=
 =?utf-8?B?cDZvNnpnbkFVaURQeHRSMTBWTVE4VVZXN0ZieXFmQVNxaUVOd20wb0pMT2Qx?=
 =?utf-8?B?U2FGVFhTblAyOXZPOGRGZ1AzSm9haXpYMHlBQ1hqR3JUVUkyY0gvOCt4L3dL?=
 =?utf-8?B?a0IvNDFGc1RkejhtU0VQSmNOdjQyUE8xQU0xQy9hZ1YrR3NQUWJlb1h2OHR0?=
 =?utf-8?B?UGN5T3dVRWZYMDY2aW1ZaEFsMSs5TVpvNVJTTFJZVElIa2Y2d1o4MVlsRVR5?=
 =?utf-8?B?V3FiNm1mRXhPeFVabVI0SGk3dWVhU3VJQ1M3WGcvaVQ0RFhIT0hibFFUcDdQ?=
 =?utf-8?B?VEU3ejI0azY3OVdWenR6RzR5T3RINXFnLzcxRmxGRC9PZzRFK2hsQnNPdGN4?=
 =?utf-8?B?b0NRdmEwYVNkMEwrSTIyb3FnWmppVGdTM0ZzZUpkeXpYd2VqVVNqb3htd3NG?=
 =?utf-8?B?WlBhY1JpbW1GN2dNNVprcDgzaS9zUUVDcHNqUXVxdlgvVkZwU3pha2w3SEZR?=
 =?utf-8?B?elFXbGhuaFVrZEZBM1g3YjM0Uk5DZHZ0RnhnUHlTNkliQm4vNmYzQjVuTUYw?=
 =?utf-8?B?Q09NN3dxVk5ZQ05ScHZTd095bEp2VlZ3QlZTd01tSEh1dGMzU2J1c2dCTVVQ?=
 =?utf-8?B?RC94aE05T01ReFdUNEhySjJKdXRRVVR4TG9XNmFuaUFSTmNyNFY5bzNuTENy?=
 =?utf-8?B?Rmg1ZENHWko2L1VHN1ZyMXVoZ2N3MWhRRlZCRmoyVHM0dFVUQnVnc2JleVRu?=
 =?utf-8?B?d2srM1pvRWdhTk5mbWxZaVN4MXRiMFZqMytENWRVb1Q5cWpDbXh1S3BkeUpK?=
 =?utf-8?B?Z0p4RUw3dHZRbkpBV1pBZmtDMHdHY0thQWlBYXJVOG1sS21HdkNiYndQVzZn?=
 =?utf-8?B?R0oxVkk5WmtIQWVUMUxYZ2RLRk1kdnVpaVRzVWJQYSt5eW5iOEtkWlJSSWFK?=
 =?utf-8?B?WVRKY1hablU4WEJ5bkFqV2poZnJ0UTBmY0ZnUzA0bWlSWlFkSld6S2g1YjNV?=
 =?utf-8?B?RVRJWVdnYkdqRFhUZHErM0xZNXFxT0NONUtPN1pGRU95UCtvelJzRGZ5VXVV?=
 =?utf-8?B?M3g3ZG9rMkdIUm5oNUZKdlpCTlZVYkpsdVJDUjZTUkJpNHhRSWV6eEJyWmxk?=
 =?utf-8?B?WVY0anF4TDNlVEMrcXBSdUVFS1JwL0FUOVpmcWtocktLTE5vQ0FySURUQUFh?=
 =?utf-8?B?N0VkcElrMTF3Z3FwZ0EyK0wxY1pDT2tGV1c1YUtQY1lZSmhHaDNlVlNHQmE1?=
 =?utf-8?B?TjVzRUdCdkNYZGZCUHFJQVRIeU81SG9wZDNwUzNsV3BHeFBQMyswK0lBMUh1?=
 =?utf-8?B?b3BBMlBIUWVkNXM1MTJjVk04RjgxOFloYi9FbVdVdjRrV2hwU2QxZDd5dk9w?=
 =?utf-8?B?dkR2d1EzN2xqUXlTUVdPY2VzUTRQVWkwZFBOMnRzT1ZTN216VDd4dlpDZ1RR?=
 =?utf-8?B?cmZWSGxUT1lFV3BwUmcwc3hEQ3NXYktvc3NSSkRKZTVMNjA0bDhnSk1Xb2Y5?=
 =?utf-8?B?WVB3VEdYeStTTUo2c1ZvM2JvTnhxejlCSkJhdTdXa0tZbjdyamtLMjF3MlJP?=
 =?utf-8?B?cUhkTmhzQTV4Si94blhjUVFUYUo2MVVCc0tBVzZoT0VLb2RNaFpjam9uZk0w?=
 =?utf-8?B?ODBGWkxpczU3TVVHMzk0alB1MFI2UHpyckN3Um10bEZ4dm5SNUFaY1dLOEgw?=
 =?utf-8?B?N2NFZTFiYzZyalg2VE1STXZtR2lhMDlQN1QzSm1PUTV3UGpMRGRjdWFzRkVC?=
 =?utf-8?B?RUlHNEtuckhFUS9OYit6S0xlSzZ1TXhaLzZsVnhnSkF4Tzk5aURock5hZ3ZZ?=
 =?utf-8?B?V1RZUVlMSkM5Rm5sbUJSQ1ZETURYT1h6TnhzOU9ZeXdIZFdKU1dobVF6L2c0?=
 =?utf-8?B?QzIrdnFnVEVpODFlcE1CeGZaZnBFUnFJdVJnV2dNUjlCbERacmVUVkFZUWww?=
 =?utf-8?B?U3FHR2RaTVdXdXJRYWQ2eVFGRUd1RzRFeWwrQVlRUzZVZFF3Sk9nNWREYk9R?=
 =?utf-8?B?aVV5ZGlDWlhCdTRaS3ZUZmxKNHNYRTJBQS92RVE5YUV6RkFQMTZlRUFzbk9D?=
 =?utf-8?B?Q000d3M3KzFZODkwdklsYmdKN1ZOQ0FreCtCN3VKcndSdXhDcHZxa0tia2kw?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d46ff171-c593-42a8-a791-08db214c26a1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:45:15.4916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHm+jDVXpSxNMg+Qcvt71Ng56OsMtxnFL1DhPJ9SZKwfG6uZPuSjT8aBZSmPulOLmiE/TkIWfL0T6/DU7m9gvMEVvG0ZSI780JXhElou85s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5155
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jehoon Park wrote:
> On Wed, Mar 08, 2023 at 01:58:11PM -0800, Alison Schofield wrote:
> > On Wed, Mar 08, 2023 at 10:22:41AM -0800, Ira Weiny wrote:
> > > Jehoon Park wrote:
> > > > On Tue, Mar 07, 2023 at 12:18:38PM -0800, Alison Schofield wrote:
> > > > > On Tue, Mar 07, 2023 at 05:21:00PM +0900, Jehoon Park wrote:
> > > > > > From: jehoon park <jehoon.park@samsung.com>
> > > > > > 
> > > > > > This patchset supports CXL IDENTIFY mailbox command and corresponding
> > > > > > cxl tool interface command.
> > > > > > 
> > > > > > CXL 3.0 Spec 8.2.9.8.1 defines IDENTIFY command which retrieves basic
> > > > > > information about CXL memory device. The information consist of device's
> > > > > > firmware version, capacity, LSA size, event log size, poison list size,
> > > > > > inject poison limit, poison handling capabilities and QoS telemetry
> > > > > > capabilities. Firmware version, capacity and LSA size are already supported
> > > > > > and used for partition commands or sysfs attributes while others are not.
> > > > > > Since patches about event log [1] and poison [2] are discussed recently,
> > > > > > support for those information will be helpful.
> > > > > 
> > > > > Hi Jehoon,
> > > > > 
> > > > > Does this need to be a separate command? Identify fields can be included
> > > > > in cxl list options. For example, the -I option to cxl list, issues the
> > > > > identify command and includes the partition related entries in that json
> > > > > output.
> > > > > 
> > > > > There are other identify fields that need to be picked up, like the
> > > > > poison related fields.  They need to be added to the cxl list 
> > > > > options. We may want to include some when we list the poison, and
> > > > > some as an option in the memdev listing.
> > > > > 
> > > > > Is there some reasoning behind separating this out? If not, can we look
> > > > > to add the missing fields to the various cxl-list options and add
> > > > > new cxl-list options where needed?
> > > > > 
> > > > > Alison
> > > > > 
> > > > 
> > > > Hi Alison, thank you for comments.
> > > > 
> > > > I suggested separate identify command since it retrieves basic information
> > > > about memdev. Since cxl-list command lists all cxl objects, I intended to
> > > > focus memdev information by separating it. Also, I referred to nvme-cli
> > > > which has id-ctrl and id-ns commands.
> > > > 
> > > > However, as you commented, some fields were already included in cxl-list.
> > > > I think the idea that providing information to proper listing option also
> > > > makes sense.
> > > > 
> > > > Then, by following the approach, including fields to cxl-list options,
> > > > identify fields could be included like below. Do they look fine?
> > > > 
> > > > 1. FW version and LSA size are included when listing memdev. ("list -m memdev")
> > > > 2. For poison related fields (poison_list_max size and inject_poison_limit),
> > > > include them when listing poison. ("--media-errors" option, patch [1])
> > > > 3. For capabilities fields, add new option "-C, --capabilities" to the
> > > > memdev listing. (I see there exists same option for listing nvdimm device)
> > > > 
> > > > However, I'm confused about event_log_size fields. Could they be included
> > > > in capabilities option too? or require new option like "--event"?
> > > 
> > > Fundamentally why does user space need to know the event log sizes?
> > > 
> > > I do like the idea of getting the 'raw' results of the identify command in
> > > it's entirety.
> > > 
> > > What if list has an '--identify' option which adds the list of Identify
> > > values as a child json object.
> > >
> > That's a good way to add it. That'll give you all the fields in one
> > place, and then, we can still think about if we want to spit out
> > specific fields (ie poison related) when we are doing a poison command.
> > You will have added all the libcxl accessors, making those easier to add.
> > Alison
> > 
> > 
> > > Ira
> 
> The idea adding new list option “—identify” to display raw data from Identify
> looks good! Providing proper fields to other options will be helpful for users,
> however, I think it may be covered by different patchset after basic support
> for Identify command is fully handled.
> 
> I will revise this patchset by applying your valuable comments. Thank you.

I would prefer that users not need to know about a new --identify
option, just include all the fields you would emit in that scenario in
"cxl list -M" by default. Firmware version makes sense to add, but I do
not see the end user value of emitting the Event Log Size, for example.
I am just asking to be thoughtful about not including inactionable
information in the output, as most of what identify reports is already
available via "cxl list -MI".
