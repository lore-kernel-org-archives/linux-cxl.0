Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E7BC678D5
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Mar 2023 17:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjCGR06 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Mar 2023 12:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjCGR0b (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Mar 2023 12:26:31 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915E99E64A
        for <linux-cxl@vger.kernel.org>; Tue,  7 Mar 2023 09:21:09 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PWMfj0fDdz6J7mm;
        Wed,  8 Mar 2023 01:21:01 +0800 (CST)
Received: from localhost (10.48.150.191) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 7 Mar
 2023 17:21:06 +0000
Date:   Tue, 7 Mar 2023 17:21:05 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Viacheslav Dubeyko <slava@dubeyko.com>
CC:     <linux-cxl@vger.kernel.org>, <a.manzanares@samsung.com>,
        <viacheslav.dubeyko@bytedance.com>
Subject: Re: CXL Fabric Manager (FM) architecture diagrams
Message-ID: <20230307172105.00006132@Huawei.com>
In-Reply-To: <20230306185913.1060918-1-slava@dubeyko.com>
References: <20230306185913.1060918-1-slava@dubeyko.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.48.150.191]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon,  6 Mar 2023 10:59:13 -0800
Viacheslav Dubeyko <slava@dubeyko.com> wrote:

> Hi Jonathan,
> 
> You can find diagram online now:
> 
> (1) Diagram 1: single host with Fabric Manager (FM)
> https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram1-cxl-fm-single-host-with-fm.pdf

Whilst accurate that you might only be able to control the switch, I would add one MLD to this
diagram so that tunneling can be discussed.  It's minimal in sense of near minimal number of
components that might exist in a switched system

Thanks to asciiflow.com + some editing of the resutl - fingers crossed this works.
Obviously these can't be as rich as your nice diagrams so I've
left out what the connections are, but having them inline has
it's advantages as well.

I've played fast and loose with some of the terminology and not checked
it against the spec naming.  I've also left it vague how an application
talks to the orchestrator.  That was via agent in your terms I think

┌───────────────────┐    ┌───────────────┐   ┌────────────────┐
│                   │    │               │   │                │
│                   │    │   ┌───────┐   │   │ ┌────────────┐ │
│                   │    │   │       ├───┼───┼─►FM Owned LD │ │
│           ┌───┐   │    │   │Switch │   │   │ └────────────┘ │
│           │FM ├───┼────┼───►  CCI  │   ├───┤                │
│           └───┘   │    │   │       │   │   │ MLD 1          │
│                   │    │   └──────┬┘   │   └────────────────┘
│              ┌────┤    │          │    │
│              │RP0 ├────┤          │    │   ┌────────────────┐
│              └────┤    │          │    │   │                │
│                   │    │          │    │   │ ┌────────────┐ │
│              ┌────┤    │          └────┼───┼─►FM Owned LD │ │
│              │RP1 ├────┤               ├───┤ └────────────┘ │
│              └────┤    │               │   │                │
│ Host A            │    │ SWITCH        │   │ MLD 2          │
└───────────────────┘    └───────────────┘   └────────────────┘

> 
> (2) Diagram 2: single host with orchestrator
> https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram2-cxl-fm-single-host-with-orhestrator.pdf

Actually having an FM in a switch might happen, but there is no spec defined way of doing it.
From a software architecture point of view it's no different from another host talking to the
switch - just think of sticking a BMC down next to the switch chip.
Having the orchestrator in the host is also rather odd though it could in theory happen.
Typically the orchestrator is considered a 'cloud' level thing floating way above individual host.
Without any loss of generality I'd always have the orchestrator as something on it's own
machine chatting over a network to the Agents and FM-API accessed devices.

Something like


    ┌──────────────────────┐    ┌────────┐
    │                      │    │        │
    │                      │    │        │
    │   Orchestrator ──────┼────►  FM    │
    │                      │    │        │
    └───▲──────────────────┘    └─┬──────┘
        │                         │
  ┌─────┼─────────────┐    ┌──────┼────────┐   ┌────────────────┐
  │     │             │    │      │        │   │                │
  │     │             │    │  ┌───▼────┐   │   │ ┌────────────┐ │
  │     │             │    │  │ Switch ├───┼───┼─►FM Owned LD │ │
  │ ┌───┴──┐          │    │  │   CCI  │   │   │ └────────────┘ │
  │ │ APP  │          │    │  │ or MCTP│   ├───┤                │
  │ │      │          │    │  │   CCI  │   │   │ MLD 1          │
  │ └──────┘          │    │  └───────┬┘   │   └────────────────┘
  │              ┌────┤    │          │    │
  │              │RP0 ├────┤          │    │   ┌────────────────┐
  │              └────┤    │          │    │   │                │
  │                   │    │          │    │   │ ┌────────────┐ │
  │              ┌────┤    │          └────┼───┼─►FM Owned LD │ │
  │              │RP1 ├────┤               ├───┤ └────────────┘ │
  │              └────┤    │               │   │                │
  │ Host A            │    │ SWITCH        │   │ MLD 2          │
  └───────────────────┘    └───────────────┘   └────────────────┘

> 
> (3) Diagram3: Multi-headed device
> https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram3-cxl-fm-multi-headed-device.pdf

Looks good though there is a simpler single host version.

 ┌───────────────────┐    ┌─────────────────────┐
 │           ┌───┐   │    │ ┌────────────┐      │
 │           │FM ├───┼────┼─► Mailbox CCI│      │
 │           └───┘   │    │ └────────────┘      │    
 │                   │    │ ┌─────▼───────┐     │
 │              ┌────┤    │ │ LD Pool CCI │     │
 │              │RP0 ├────┤ └─────────────┘     │
 │              └────┤    │                     │
 │              ┌────┤    │                     │
 │              │RP1 ├────┤                     │
 │              └────┤    │                     │
 │ Host A            │    │ MHD 1               │
 └───────────────────┘    └─────────────────────┘

I'd jump from single host to the multi host with external FM and
orchestator.

        ┌──────────────────────┐    ┌────────┐
        │                      │    │        │
        │                      │    │        │
  ┌─────►   Orchestrator ──────┼────►  FM    │
  │     │                      │    │        │
  │     └───▲──────────────────┘    └────┬───┘
  │         │                            │
  │   ┌─────┼─────────────┐      ┌───────┼─────────────┐
  │   │     │             │      │ ┌─────▼───────┐     │
  │   │     │             │      │ │ Mailbox CCI │     │
  │   │ ┌───┴──┐      ┌───┤      │ └─────-───────┘     │
  │   │ │ APP  │      │RP0├──────┤       │             │
  │   │ │      │      └───┤      │ ┌─────▼───────┐     │
  │   │ └──────┘          │      │ │ LD Pool CCI │     │
  │   │                   │      │ └─────────────┘     │
  │   │ Host A            │      │                     │
  │   └───────────────────┘      │                     │
  │   ┌───────────────────┐      │                     │
  └───┼─┬──────┐      ┌───┤      │                     │
      │ │ APP  │      │RP0├──────┤                     │
      │ │      │      └───┤      │                     │
      │ └──────┘          │      │                     │
      │ Host B            │      │ MHD 1               │
      └───────────────────┘      └─────────────────────┘



> 
> (4) Diagram 4: Multi-headed device + Orchestrator
> https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram4-cxl-fm-multi-headed-device-orchestrator.pdf
I'd put the orchestrator in it's own 'host' as above...  I've drawn it with a mailbox cci but
could be a mctp CCI. 
> 
> (5) Diagram5: Multiple hosts with Fabric Manager (FM)
> https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram5-cxl-fm-multiple-hosts-with-fm.pdf

Another one where I'd separate the FM from the switch.  It may be near the switch but
it's talking fm-api to the switch and that's an interface that is well defined.

       ┌──────────────────────┐    ┌────────┐
 ┌─────►   Orchestrator ──────┼────►  FM    │
 │     └───▲──────────────────┘    └────┬───┘
 │   ┌─────┼─────────────┐              │
 │   │     │             │       ┌──────┼────────┐   ┌────────────────┐
 │   │     │             │       │  ┌───▼────┐   │   │ ┌────────────┐ │
 │   │ ┌───┴──┐      ┌───┤       │  │ Switch ├───┼───┼─►FM Owned LD │ │
 │   │ │ APP  │      │RP0├───────┤  │   CCI  │   │   │ └────────────┘ │
 │   │ │      │      └───┤       │  │ or MCTP│   ├───┤                │
 │   │ └──────┘          │       │  │   CCI  │   │   │ MLD 1          │
 │   │                   │       │  └───────┬┘   │   └────────────────┘
 │   │ Host A            │       │          │    │
 │   └───────────────────┘       │          │    │   ┌────────────────┐
 │   ┌───────────────────┐       │          │    │   │ ┌────────────┐ │
 │   │                   │       │          └────┼───┼─►FM Owned LD │ │
 │   │                   │       │               ├───┤ └────────────┘ │
 │   │                   │       │               │   │                │
 └───┼─┬──────┐      ┌───┤       │ SWITCH        │   │ MLD 2          │
     │ │ APP  │      │RP0├───────┤               │   └────────────────┘
     │ │      │      └───┤       │               │
     │ └──────┘          │       └───────────────┘
     │ Host B            │
     └───────────────────┘
> 
> (6) Diagram 6: Multiple hosts with orhestrator
> https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram6-cxl-fm-multiple-hosts-with-orhestrator.pdf

I'm not sure there is a need to separate the case where there
is an orchestrator in the loop from when there isn't.  Hence I just threw one on the diagram above.

> 
> (7) Diagram 7: Distributed Fabric Manager (FM)
> https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram7-cxl-fm-distributed-fm.pdf
>
Looks like a set of FMs, not what I'd think of as a distributed FM.
Only makes sense to me if more like this... 

     ┌──────────────────────┐
 ┌───►   Orchestrator ──────┼─────────────────────────────────────────┐
 │   │   ▲                  │                                         │
 │   └───┬──────────┬───────┘                                         │
 │       │          │                                                 │
 │       │          │            ┌────────┐                           │
 │       │          └────────────►  FM1   │                           │
 │       │                       └────┬───┘                           │
 │ ┌─────┼─────────────┐              │                               │
 │ │     │             │       ┌──────┼────────┐   ┌────────────────┐ │
 │ │     │         ┌───┤       │      │        │   │                │ │
 │ │     │         │RP0├───────┤  ┌───▼────┐   │   │ ┌────────────┐ │ │
 │ │ ┌───┴──┐      └───┤       │  │ Switch ├───┼───┼─►FM Owned LD │ │ │
 │ │ │ APP  │          │       │  │   CCI  │   │   │ └────────────┘ │ │
 │ │ │      │      ┌───┤       │  │ or MCTP│   ├───┤                │ │
 │ │ └──────┘      │RP1├─────┐ │  │   CCI  │   │   │ MLD 1          │ │
 │ │               └───┤     │ │  └───────┬┘   │   └────────────────┘ │
 │ │ Host A            │     │ │          │    │                      │
 │ └───────────────────┘     │ │          │    │   ┌────────────────┐ │
 │                           │ │          │    │   │                │ │
 │ ┌───────────────────┐     │ │          │    │   │ ┌────────────┐ │ │
 │ │                   │     │ │          └────┼───┼─►FM Owned LD │ │ │
 │ │               ┌───┤     │ │               ├───┤ └────────────┘ │ │
 │ │               │RP0├─────┼─┤               │   │                │ │
 │ │ ┌──────┐      └───┤     │ │ SWITCH 1      │   │ MLD 2          │ │
 └─┼─┤ APP  │          │     │ │               │   └────────────────┘ │
   │ │      │      ┌───┤     │ │               │                      │
   │ └──────┘      │RP1├──┐  │ └───────────────┘                      │
   │               └───┤  │  │                                        │
   │ Host B            │  │  │                                        │
   └───────────────────┘  │  │                                        │
                          │  │   ┌────────┐                           │
                          │  │   │  FM2   ◄───────────────────────────┘
                          │  │   └────┬───┘
                          │  │ ┌──────┼────────┐   ┌────────────────┐
                          │  │ │  ┌───▼────┐   │   │ ┌────────────┐ │
                          │  │ │  │ Switch ├───┼───┼─►FM Owned LD │ │
                          │  └─┤  │   CCI  │   │   │ └────────────┘ │
                          │    │  │ or MCTP│   ├───┤                │
                          │    │  │   CCI  │   │   │ MLD 3          │
                          │    │  └───────┬┘   │   └────────────────┘
                          │    │          │    │   ┌────────────────┐
                          │    │          │    │   │ ┌────────────┐ │
                          │    │          └────┼───┼─►FM Owned LD │ │
                          │    │               ├───┤ └────────────┘ │
                          │    │               │   │                │
                          │    │ SWITCH 2      │   │ MLD 4          │
                          └────┤               │   └────────────────┘
                               └───────────────┘
 
> (8) Diagram 8: Layered Fabric Manager (FM) and separate orchestrator
> https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram8-cxl-fm-layered-fm-and-separate-orchestrator.pdf

I don't follow the layered part on this diagram.  My interpretation would
be something like.


       ┌──────────────────────┐    ┌────────┐
 ┌─────►   Orchestrator ──────┼────► TOP FM ├──────────────────────────────┐
 │     │   ▲                  │    │        │                              │
 │     └───┬──────────────────┘    └────┬───┘                              │
 │         │                            │                                  │
 │         │                       ┌────┴───┐                              │
 │         │                       │ BOTTOM │                              │
 │         │                       │  FM1   │                              │
 │         │                       └────┬───┘                              │
 │   ┌─────┼─────────────┐              │                                  │
 │   │     │             │       ┌──────┼────────┐   ┌────────────────┐    │
 │   │     │         ┌───┤       │      │        │   │                │    │
 │   │     │         │RP0├───────┤  ┌───▼────┐   │   │ ┌────────────┐ │    │
 │   │ ┌───┴──┐      └───┤       │  │ Switch ├───┼───┼─►FM Owned LD │ │    │
 │   │ │ APP  │          │       │  │   CCI  │   │   │ └────────────┘ │    │
 │   │ │      │      ┌───┤       │  │ or MCTP│   ├───┤                │    │
 │   │ └──────┘      │RP1├─────┐ │  │   CCI  │   │   │ MLD 1          │    │
 │   │               └───┤     │ │  └───────┬┘   │   └────────────────┘    │
 │   │ Host A            │     │ │          │    │                         │
 │   └───────────────────┘     │ │          │    │   ┌────────────────┐    │
 │                             │ │          │    │   │                │    │
 │                             │ │          │    │   │ ┌────────────┐ │    │
 │   ┌───────────────────┐     │ │          └────┼───┼─►FM Owned LD │ │    │
 │   │               ┌───┤     │ │               ├───┤ └────────────┘ │    │
 │   │               │RP0├─────┼─┤               │   │                │    │
 │   │ ┌──────┐      └───┤     │ │ SWITCH 1      │   │ MLD 2          │    │
 └───┼─┤ APP  │          │     │ │               │   └────────────────┘    │
     │ │      │      ┌───┤     │ │               │                         │
     │ └──────┘      │RP1├──┐  │ └───────────────┘                         │
     │               └───┤  │  │                                           │
     │ Host B            │  │  │                                           │
     └───────────────────┘  │  │                                           │
                            │  │   ┌────────┐                              │
                            │  │   │ BOTTOM │                              │
                            │  │   │  FM2   ◄──────────────────────────────┘
                            │  │   └────┬───┘
                            │  │ ┌──────┼────────┐   ┌────────────────┐
                            │  │ │  ┌───▼────┐   │   │ ┌────────────┐ │
                            │  │ │  │ Switch ├───┼───┼─►FM Owned LD │ │
                            │  └─┤  │   CCI  │   │   │ └────────────┘ │
                            │    │  │ or MCTP│   ├───┤                │
                            │    │  │   CCI  │   │   │ MLD 3          │
                            │    │  └───────┬┘   │   └────────────────┘
                            │    │          │    │   ┌────────────────┐
                            │    │          │    │   │ ┌────────────┐ │
                            │    │          └────┼───┼─►FM Owned LD │ │
                            │    │               ├───┤ └────────────┘ │
                            │    │ SWITCH 2      │   │ MLD 4          │
                            └────┤               │   └────────────────┘
                                 └───────────────┘
> 
> (9) Diagram 9: BMC based layered Fabric Manager (FM)
> https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram9-cxl-fm-bmc-based-layered-fm.pdf

I don't follow what the BMC is in this diagram.

The BMC is just a (cheap) host that happens to have some elements of the overall management
infrastructure on it.  Let it be any of the FMs floating around on their own in the
diagrams above.  The diagram immediately above might be built with 3 BMCs or
as a single BMC like this...

      ┌──────────────────────┐
  ┌───►   Orchestrator       │
  │   └───▲──────────┬───────┘    ┌────────┐
  │       │          │            │ ┌────┐ │
  │       │          └────────────►─┤FM  │ ├───────────────────────────┐
  │       │                       │ └──┬─┘ │                           │
  │       │                       │BMC │   │                           │
  │       │                       └────┼───┘                           │
  │ ┌─────┼─────────────┐              │                               │
  │ │     │             │       ┌──────┼────────┐   ┌────────────────┐ │
  │ │     │         ┌───┤       │      │        │   │                │ │
  │ │     │         │RP0├───────┤  ┌───▼────┐   │   │ ┌────────────┐ │ │
  │ │ ┌───┴──┐      └───┤       │  │ Switch ├───┼───┼─►FM Owned LD │ │ │
  │ │ │ APP  │          │       │  │   CCI  │   │   │ └────────────┘ │ │
  │ │ │      │      ┌───┤       │  │ or MCTP│   ├───┤                │ │
  │ │ └──────┘      │RP1├─────┐ │  │   CCI  │   │   │ MLD 1          │ │
  │ │               └───┤     │ │  └───────┬┘   │   └────────────────┘ │
  │ │ Host A            │     │ │          │    │                      │
  │ └───────────────────┘     │ │          │    │   ┌────────────────┐ │
  │                           │ │          │    │   │                │ │
  │ ┌───────────────────┐     │ │          │    │   │ ┌────────────┐ │ │
  │ │                   │     │ │          └────┼───┼─►FM Owned LD │ │ │
  │ │               ┌───┤     │ │               ├───┤ └────────────┘ │ │
  │ │               │RP0├─────┼─┤               │   │                │ │
  │ │ ┌──────┐      └───┤     │ │ SWITCH 1      │   │ MLD 2          │ │
  └─┼─┤ APP  │          │     │ │               │   └────────────────┘ │
    │ │      │      ┌───┤     │ │               │                      │
    │ └──────┘      │RP1├──┐  │ └───────────────┘                      │
    │               └───┤  │  │                                        │
    │ Host B            │  │  │                                        │
    └───────────────────┘  │  │                                        │
                           │  │        ┌───────────────────────────────┘
                           │  │ ┌──────┼────────┐   ┌────────────────┐
                           │  │ │  ┌───▼────┐   │   │ ┌────────────┐ │
                           │  │ │  │ Switch ├───┼───┼─►FM Owned LD │ │
                           │  └─┤  │   CCI  │   │   │ └────────────┘ │
                           │    │  │ or MCTP│   ├───┤                │
                           │    │  │   CCI  │   │   │ MLD 3          │
                           │    │  └───────┬┘   │   └────────────────┘
                           │    │          │    │   ┌────────────────┐
                           │    │          │    │   │ ┌────────────┐ │
                           │    │          └────┼───┼─►FM Owned LD │ │
                           │    │               ├───┤ └────────────┘ │
                           │    │ SWITCH 2      │   │ MLD 4          │
                           └────┤               │   └────────────────┘
                                └───────────────┘
> 
> So, have I missed something?
> Should we correct something on diagrams?
> Does it look good?

Thare are far too many things we should perhaps show on these diagrams, but
I suspect it will mostly fall out of any layered design.

We could draw one incredibly complex diagram that does everything :)

*crossed fingers the ascii art fun above looks ok*

Thanks for getting this started btw! I was completely failing to start
whereas once there was a proposal it became easier to have a go!

Jonathan

> 
> Thanks,
> Slava.

