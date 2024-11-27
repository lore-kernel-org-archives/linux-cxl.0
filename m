Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4221BC3F;
	Wed, 27 Nov 2024 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732732397; cv=none; b=f0yPKhcmDGOX5sgv1vRVsZUh1tZNYkN0qiRn4aHh3nMkpugCTmfdzPcTNUcPEkT4all3N0AX5+DQwN1gNnaFDmNPIhRYo5OqYO5NcwXlqK8I2IR+0c8dlmFR1lGXzUs5+uHhEUvEU0g61n+C/+0EPQPdK3r+Sa4o7cSBzApJBfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732732397; c=relaxed/simple;
	bh=9zXd8RmiNkmqLklKwkazP0hHcI83JqlwTMxS3ZY+S0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awPTTr9Hiv5UyBMeSINhGkY8BNxmdOOADu/GO5MYd+dNi09gb1+oaUPbLlqA/cxY+s0Tl+xvEBxRFMkl9+Iy7MR9NZtF0LETDTK+v7RhzNdT7xxJs/J9UAA0QDGAG2jebr2c9xlOxadAWi1VHqazkgh3e9c4NiA9C47WTijW1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7516FC4CECC;
	Wed, 27 Nov 2024 18:33:15 +0000 (UTC)
Date: Wed, 27 Nov 2024 13:34:07 -0500
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
Message-ID: <20241127133407.7bc1376a@gandalf.local.home>
In-Reply-To: <53a299d3cca6417d90d553e8399f834b@huawei.com>
References: <20241120093745.1847-1-shiju.jose@huawei.com>
	<20241120093745.1847-4-shiju.jose@huawei.com>
	<180fcfd623c64cdb86cdc9059f749af0@huawei.com>
	<20241126120237.1598854d@gandalf.local.home>
	<a24524dccbf442d5a3c910d7f46c7b6c@huawei.com>
	<20241127104132.6c1729e1@gandalf.local.home>
	<53a299d3cca6417d90d553e8399f834b@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/gj_VQ.qi4BsFaumOAmUndPT"

--MP_/gj_VQ.qi4BsFaumOAmUndPT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 27 Nov 2024 18:20:26 +0000
Shiju Jose <shiju.jose@huawei.com> wrote:

> I tested removing hdr_uuid and region_uuid from the rasdaemon test setup
> as you suggested. As a result, libtraceevent parses correctly, as you mentioned.
> 
> However, I encounter  similar parsing error ("FAILED TO PARSE") when I add two additional
> decoded strings (%s) to the TP_printk, replacing (%u). Please see the attached format file,
> "format_cxl_general_media_v3.1_basic", for your reference.

Are you sure. I don't see anything wrong with that one. Which version of
libtraceevent do you have?

> 
> I've also attached another format file, "format_cxl_general_media_v3.1_full",
> which contains the complete TP_printk() intended.

This one has some complex arguments and also uses the '&' address of an
argument.

>  
> Can you please help or else can you share how to debug these errors in the
> libtraceevent setup?

Basically, I use the attached program (that just links to libtraceevent).

Note, I need to delete the first line of your files, which has the "cat"
command. But you can run this on the file itself:

  ./tep_load_event /sys/kernel/tracing/events/cxl/cxl_general_media/format

But you may need to be root to do that. If root just copies that file, you
can then run it as non-root.

 # cp /sys/kernel/tracing/events/cxl/cxl_general_media/format /tmp
 $ ./tep_load_event /tmp/format

I run it under gdb and see where it fails. But it should let you know if it
will pass or not. I put a breakpoint on tep_warning and when it gets hit, I
examine what it did up to that point.

-- Steve


--MP_/gj_VQ.qi4BsFaumOAmUndPT
Content-Type: text/x-c++src
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=tep_load_event.c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>

#include <event-parse.h>

static char *argv0;

static char *get_this_name(void)
{
	static char *this_name;
	char *arg;
	char *p;

	if (this_name)
		return this_name;

	arg = argv0;
	p = arg+strlen(arg);

	while (p >= arg && *p != '/')
		p--;
	p++;

	this_name = p;
	return p;
}

static void usage(void)
{
	char *p = get_this_name();

	printf("usage: %s exec\n"
	       "\n",p);
	exit(-1);
}

static void __vdie(const char *fmt, va_list ap, int err)
{
	int ret = errno;
	char *p = get_this_name();

	if (err && errno)
		perror(p);
	else
		ret = -1;

	fprintf(stderr, "  ");
	vfprintf(stderr, fmt, ap);

	fprintf(stderr, "\n");
	exit(ret);
}

void die(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	__vdie(fmt, ap, 0);
	va_end(ap);
}

void pdie(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	__vdie(fmt, ap, 1);
	va_end(ap);
}

int main (int argc, char **argv)
{
	struct tep_handle *tep;
	off_t size;
	char *buf;
	int ret;

	argv0 = argv[0];

	if (argc < 2)
		usage();

	tep = tep_alloc();
	if (!tep)
		pdie("tep_alloc");

	tep_set_loglevel(TEP_LOG_ALL);

	ret = open(argv[1], O_RDONLY);
	if (ret < 0)
		pdie(argv[1]);
	size = lseek(ret, 0, SEEK_END);
	if (size < 0)
		pdie("lseek");

	lseek(ret, 0, SEEK_SET);
	buf = malloc(size);
	if (!buf)
		pdie("malloc");

	size = read(ret, buf, size);
	if (size < 0)
		pdie("read");
	close(ret);

	ret = tep_parse_event(tep, buf, size, "sys");
	if (ret < 0)
		pdie("tep_parse_event");

	free(buf);
	tep_free(tep);
	return 0;
}

--MP_/gj_VQ.qi4BsFaumOAmUndPT--
