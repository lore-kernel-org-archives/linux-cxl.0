Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F8B5B05E;
	Tue, 26 Nov 2024 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732640509; cv=none; b=BmUkhAwocYjbIyzU5TVZFR0mhuNX0ObRpIRSPQ19BcWXOFBNxxG0kj/9IG/T7d5uaLK77TD1lZ3WVmvUzgF6PafWCErfOckSOsxErR/1LNDX7xxkfRkmpTKV/cKjN/w+znu4hsS9skp/T5SvNpqNeqP1c9CMDAIcOU94O/xKQ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732640509; c=relaxed/simple;
	bh=KS3uQSmdx/p7NjrB6/BuwdQYm9lHL0zkO1udfLIJ0Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EvcI26up1T9WvsjuSdwN5IubvendnLAgaf7nqTlZtmFX36VckZ2tgXNNRs72X+eaXDkChsMa+HgDL2NtNnrCI9aMbHXrT+AIUynBl39tVBeLBAkQVKBNXZewU2kYDnH1lxI4De5F7yAUB2ahojXt60EbFqqkdqnApWXjwkcB7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A57AC4CECF;
	Tue, 26 Nov 2024 17:01:47 +0000 (UTC)
Date: Tue, 26 Nov 2024 12:02:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "alison.schofield@intel.com"
 <alison.schofield@intel.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>, "dave@stgolabs.net"
 <dave@stgolabs.net>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, tanxiaofei
 <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: Re: [PATCH v4 3/6] cxl/events: Update General Media Event Record to
 CXL spec rev 3.1
Message-ID: <20241126120237.1598854d@gandalf.local.home>
In-Reply-To: <180fcfd623c64cdb86cdc9059f749af0@huawei.com>
References: <20241120093745.1847-1-shiju.jose@huawei.com>
	<20241120093745.1847-4-shiju.jose@huawei.com>
	<180fcfd623c64cdb86cdc9059f749af0@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Nov 2024 11:51:23 +0000
Shiju Jose <shiju.jose@huawei.com> wrote:

> We are encountering a parsing error ("FAILED TO PARSE") from libtraceevent  when it
> tries to parse some of the CXL trace events for the user-space tool rasdaemon. 
> This issue appeared after new fields were added to the trace events. 
> It was found that the issue does not occur when all or some of the decoded strings
> for the event's data and flags are removed from the TP_printk() function in the kernel,
> and only the values are printed instead.
> https://elixir.bootlin.com/linux/v6.12/source/drivers/cxl/core/trace.h
> https://lore.kernel.org/lkml/20241120093745.1847-1-shiju.jose@huawei.com/
> 
> Below is the information from the debugging in libtraceevent:
> The failure occurs in the following functions and locations within libtraceevent:
> File: src/event-parse.c
> Function: event_read_format()
> ret = event_read_fields(event->tep, event, &event->format.fields); if (ret < 0)
>     return ret;
> 
> Function: event_read_fields()
> if (test_type_token(type, token, TEP_EVENT_ITEM, "field"))
>     goto fail;
> 
> Can you recognize if there are any limitations or issues  that would prevent
> libtraceevent from parsing the trace event in the condition described above?

Can you show me the output of the format files for the affected trace events:

 # cat /sys/kernel/tracing/cxl/<affected_event>/format

You can attach it too if your email does whitespace mangling.

Thanks,

-- Steve
