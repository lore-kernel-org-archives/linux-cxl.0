Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619E318E3A
	for <linux-cxl@vger.kernel.org>; Fri, 15 Mar 2024 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710499492; cv=none; b=CzT/xyr/ekFwf9reXbJ6iSSX18ydHTYcw1tAXJ++2H2I1sxIbvMcj1MpR3OS7IKEqVk9ORRmMlKunhf9Q2BYWNhRJsL98y71ZP9IQJ9t7JmOzkNWev76l2e0YkQrYYZzkBEz0rNApnvbK95DdSus+QYDGekt7NDxrAuYaKlL1Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710499492; c=relaxed/simple;
	bh=9WyjwAKK3Fu6MCCYLiEdWFmMr9BNARBUT08g/ibILmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NcXyg1awBSMeX0/jbYA33gfgnJCVREq+g0ZPGQtXDieJtn+a4dOiqen4i7mQeRFPa/tGsUkug+UcDxHNKmc63nx0XjPPQjojj4fbAL/BPwcdVNAl24Eh7itMhJXEOVEF9qDhy2yGUw+U92j1btafcTHKQvDINBI0xkdpNe2VqUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F657C433F1;
	Fri, 15 Mar 2024 10:44:51 +0000 (UTC)
Date: Fri, 15 Mar 2024 06:47:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/trace: Properly initialize cxl_poison region
 name
Message-ID: <20240315064703.2202cc69@gandalf.local.home>
In-Reply-To: <ZfN8AP/KdbsN32l1@aschofie-mobl2>
References: <20240314201217.2112644-1-alison.schofield@intel.com>
	<20240314164136.6d10aa28@gandalf.local.home>
	<ZfNmfCmgCs4Nc+EH@aschofie-mobl2>
	<20240314171737.2025ef60@gandalf.local.home>
	<ZfN8AP/KdbsN32l1@aschofie-mobl2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Mar 2024 15:36:48 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Thu, Mar 14, 2024 at 05:17:37PM -0400, Steven Rostedt wrote:
> > On Thu, 14 Mar 2024 14:05:00 -0700
> > Alison Schofield <alison.schofield@intel.com> wrote:
> >  =20
> > > > I'm still curious to why NULL didn't work. I guess it may never hav=
e as I
> > > > noticed there's nothing else doing that. There are cases that a var=
iable
> > > > returns NULL and the __string() handles it. But I guess the compile=
r gets
> > > > confused if the NULL is a possible return to the condition in __str=
ing().   =20
> > >=20
> > > Here's the full warning spew:
> > >=20
> > > In file included from ./include/trace/define_trace.h:102,
> > >                  from drivers/cxl/core/trace.h:713,
> > >                  from drivers/cxl/core/trace.c:8:
> > > drivers/cxl/core/./trace.h: In function =E2=80=98trace_event_get_offs=
ets_cxl_poison=E2=80=99:
> > > ./include/trace/stages/stage5_get_offsets.h:50:21: warning: argument =
1 null where non-null expected [-Wnonnull]
> > >    50 |                     strlen((src) ? (const char *)(src) : "(nu=
ll)") + 1)
> > >       |                     ^~~~~~
> > > ./include/trace/trace_events.h:263:9: n =20
> >=20
> > The full warning didn't add any new information. The above was all I
> > needed. But I'm curious if you applied this patch if the warning will go
> > away. (Note I didn't test nor compile this).
> >=20
> > -- Steve
> >=20
> > diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/=
stages/stage5_get_offsets.h
> > index e30a13be46ba..dfae18d8f4df 100644
> > --- a/include/trace/stages/stage5_get_offsets.h
> > +++ b/include/trace/stages/stage5_get_offsets.h
> > @@ -9,6 +9,13 @@
> >  #undef __entry
> >  #define __entry entry
> >   =20
>=20
> +#ifndef STAGE5_H_INCLUDED
> +#define STAGE5_H_INCLUDED
> > +static inline const char *__string_src(const char *str)
> > +{
> > +	if (!str)
> > +		return "(null)";
> > +	return str;
> > +} =20
> +#endif /* STAGE5_H_INCLUDED */
>=20
> Happy to try it out...
>=20
> Your diff, with the ifdef above, makes the compiler happy and it functions
> as wanted - no garbage in the fields.

I created the patch:

  https://lore.kernel.org/linux-trace-kernel/20240314232754.345cea82@rorsch=
ach.local.home/

That adds this. But now the kernel will not build because it requires the
fix of this patch. Otherwise it fails with:

In file included from /work/build/trace/nobackup/linux-test.git/include/tra=
ce/define_trace.h:102,
                 from /work/build/trace/nobackup/linux-test.git/drivers/cxl=
/core/trace.h:713,
                 from /work/build/trace/nobackup/linux-test.git/drivers/cxl=
/core/trace.c:8:
/work/build/trace/nobackup/linux-test.git/drivers/cxl/core/./trace.h: In fu=
nction =E2=80=98trace_event_get_offsets_cxl_poison=E2=80=99:
/work/build/trace/nobackup/linux-test.git/drivers/cxl/core/./trace.h:660:34=
: error: passing argument 1 of =E2=80=98__string_src=E2=80=99 from incompat=
ible pointer type [-Werror=3Dincompatible-pointer-types]
  660 |                 __string(region, region)
      |                                  ^~~~~~
      |                                  |
      |                                  struct cxl_region *

I like that the patch also catches other bugs where non strings are passed
to __string(). But I can't send this to Linus if it breaks the build.

I'm breaking my pull request up as there's some other places that break the
build with my new checks. I'll do a pull of all my updates first, and after
Linus pulls in my change I will base the next pull off of that merge commit.

But this requires that this fix is in Linus's tree before that. If not, can
I take this fix and add it to that later pull request with all the tests. I
want to make sure that the kernel always builds.

-- Steve


>=20
> > +
> >  /*
> >   * Fields should never declare an array: i.e. __field(int, arr[5])
> >   * If they do, it will cause issues in parsing and possibly corrupt the
> > @@ -47,7 +54,7 @@
> > =20
> >  #undef __string
> >  #define __string(item, src) __dynamic_array(char, item,			\
> > -		    strlen((src) ? (const char *)(src) : "(null)") + 1)
> > +		    strlen(__string_src(src)) + 1)
> > =20
> >  #undef __string_len
> >  #define __string_len(item, src, len) __dynamic_array(char, item, (len)=
 + 1) =20

