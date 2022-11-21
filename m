Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCCAC433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 21 Nov 2022 14:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiKUO1V (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 21 Nov 2022 09:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiKUO05 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 21 Nov 2022 09:26:57 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7280E13F7C
        for <linux-cxl@vger.kernel.org>; Mon, 21 Nov 2022 06:25:46 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id d20so14628066ljc.12
        for <linux-cxl@vger.kernel.org>; Mon, 21 Nov 2022 06:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jESjTJYmgT5aINFj42L4tpXTfuOFh/ZimZAIF7AHfKM=;
        b=YYVC10QOAPAsq/KOrfPZ10T9dG78zbQvB/6lUP/MLTORRRni/G+r20p/5T7Rxzw9a3
         2RNOWWlCwHQO+RviXS1fJoYHR4SPQp6bL6MUbGEGeaIuSZIKZReFZGfxMSedOCoN42Ng
         aSkdbZA/ILUFIORIsO56VxN5NUgebBLKxZtMM7XEy1vmteX0kimbj1deAN8sEvV19B1G
         DEzghO6OrllH/w91K4/N4e45gS7sY/xHSgyNuUVsxjIyjOBXk9oQ2BVyQS3Mgv+y0lgx
         gNp/9CGehmrVQpLOpvnDdZioG3YYLvwKIb0otjEeWZ+K42Qo7VMIID7BOhM8+VW7y8ut
         IOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jESjTJYmgT5aINFj42L4tpXTfuOFh/ZimZAIF7AHfKM=;
        b=rnJkZG8Ay+/YyJ/psBcJsOK44OzjYSUsUM9q1g3EsPhYsnrn3T/jF0J/l8ysxmsxRD
         gjjFC438288uw7/lgGNclucYh7VdiYIiwlPq+wv9MSjVcPIGqjsg3fck4LkySoLjVHZ9
         RQzBAOt0HZgKRR8D3T6jsm/6b1tbuFP1ASQtcPFVgfVLK8lODBQ6O2RlDe5Qryq6GuGx
         IBSnEfUev8byqUl0jDYL1mjdAGd7mZtwZpV9IcTUlM4mSUbHQS+8OwG6JMsrBKabWfTf
         xp9bqf08xdfuy5tqJcq5fiX9WFy9+DQD8UXDOp2oRjrnOw01phXU7qorTaaopiQ6sM0k
         /kTg==
X-Gm-Message-State: ANoB5pkEOjWJwFqtuB+0jF6IyZQv5Xha6xT3ZkF5mSlvGrnpz6Bd6QAH
        6u/D9z5umQwsnT6uWyHu3DeNtCXHpnA=
X-Google-Smtp-Source: AA0mqf7vc6LStPq5lAorREVJzADZ99sjUVHuVgfTbultz5rxw59Qt4Vxn24JhS9NfuYXA0yRKkRTMw==
X-Received: by 2002:a05:651c:50b:b0:26c:5db6:cd84 with SMTP id o11-20020a05651c050b00b0026c5db6cd84mr416098ljp.114.1669040744447;
        Mon, 21 Nov 2022 06:25:44 -0800 (PST)
Received: from ubuntu.armcompdev.pub.tds.tieto.com ([89.46.86.70])
        by smtp.gmail.com with ESMTPSA id b17-20020a196451000000b00498f23c249dsm2019817lfj.74.2022.11.21.06.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 06:25:44 -0800 (PST)
Date:   Mon, 21 Nov 2022 14:25:40 +0000
From:   Marek Bykowski <marek.bykowski@gmail.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: trace events
Message-ID: <20221121142540.62ebaa39@ubuntu.armcompdev.pub.tds.tieto.com>
In-Reply-To: <eb11a59e-d5ac-8ba7-06ec-ff895caffffd@intel.com>
References: <20221114202242.5f9023d3@ubuntu.armcompdev.pub.tds.tieto.com>
        <Y3bW8CLw8xcbrfav@aschofie-mobl2>
        <20221118135311.12cb241d@ubuntu.armcompdev.pub.tds.tieto.com>
        <c71a8cea-b2d1-8190-51d0-754f80aa96a0@intel.com>
        <20221118223913.075752fd@ubuntu.armcompdev.pub.tds.tieto.com>
        <eb11a59e-d5ac-8ba7-06ec-ff895caffffd@intel.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 18 Nov 2022 16:22:26 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> 
> For kernel we are enabling trace events for CXL. But those events are 
> stemmed from hardware events. Ira is enabling CXL events defined by
> the CXL spec and emitted by the devices. Alison is enabling CXL
> events for poison data. And I'm enabling CXL events for PCIe AER
> errors.
> 
> But I think you want different type of events right? i.e. the flow of 
> the driver? I believe ftrace can enable function names for ftrace. Is 
> that what you are looking for?

Apology Dave, my bad. I'm so used to into people saying ftrace
in which they really mean the trace events that I thought you referred
to the latter, which of course isn't true as the two are separate.

Honestly I've never found a real use of the ftrace, except exercising,
as to me it is more a call trace and how a developer designs the SW
rather than how the HW is managed/interogated, but in the absence of the
trace events I re-thought and went down that path.

After a several attempts and finally setting the 'trace_clock'
to global I succeeded. With the 'trace_clock' set local (default)
I had only the last ftrace events logged in - don't know really why.
Actually the ./tools/bootconfig/scripts/ftrace2bconf.sh figured that
out for me walking through the ftrace settings I had configured after
booting the Linux up.

So now with a bootconfig as this
  kernel { trace_options =  sym-addr, hash-ptr, nofunc_stack_trace,
                   \nofunc-no-repeats 
           #trace_event = "module:*"
           trace_clock = global
           trace_buf_size = 2M
           ftrace = function_graph
           max_graph_depth = 5
           ftrace_filter = "*cxl*"
  } 

I'm seeing all the functions with *cxl*.

Thanks again.
Marek
